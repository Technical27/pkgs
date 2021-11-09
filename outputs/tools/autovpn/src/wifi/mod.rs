use neli::consts::nl::{NlmF, NlmFFlags, Nlmsg};
use neli::consts::socket::NlFamily;
use neli::err::NlError;
use neli::genl::{Genlmsghdr, Nlattr};
use neli::nl::{NlPayload, Nlmsghdr};
use neli::socket::NlSocketHandle;
use neli::types::Buffer;
use neli::types::{GenlBuffer, NlBuffer};

mod attr;

use attr::{Nl80211Attr, Nl80211Cmd};

pub fn connect_genl() -> Result<NlSocketHandle, std::io::Error> {
    NlSocketHandle::connect(NlFamily::Generic, None, &[])
}

fn gen_nl80211_header(
    cmd: Nl80211Cmd,
    attrs: GenlBuffer<Nl80211Attr, Buffer>,
    nlid: u16,
    flags: &[NlmF],
) -> Nlmsghdr<u16, Genlmsghdr<Nl80211Cmd, Nl80211Attr>> {
    let genlhdr = Genlmsghdr::new(cmd, 1, attrs);
    Nlmsghdr::new(
        None,
        nlid,
        NlmFFlags::new(flags),
        None,
        None,
        NlPayload::Payload(genlhdr),
    )
}

fn parse_ifindex(bytes: &[u8]) -> u32 {
    (bytes[3] as u32) << 24
        | ((bytes[2] as u32) << 16)
        | ((bytes[1] as u32) << 8)
        | (bytes[0] as u32)
}

pub fn get_ifindex(socket: &mut NlSocketHandle, nlid: u16, ifname: &[u8]) -> Result<u32, NlError> {
    let nlhdr = gen_nl80211_header(
        Nl80211Cmd::GetInterface,
        GenlBuffer::new(),
        nlid,
        &[NlmF::Dump, NlmF::Request],
    );
    socket.send(nlhdr)?;
    let msgs: NlBuffer<u16, Genlmsghdr<Nl80211Cmd, Nl80211Attr>> = socket.recv_all()?;

    // netlink sends a "done" messages for dumps and we need to get rid of that from the buffer of messages
    if let Some(done) = socket.recv::<Nlmsg, u8>()? {
        if done.nl_flags.contains(&NlmF::Multi) && done.nl_type != Nlmsg::Done {
            return Err(NlError::new("no done msg recieved"));
        }
    }

    for msg in msgs.iter() {
        if let Some(payload) = msg.nl_payload.get_payload() {
            let attrs = payload.get_attr_handle();
            if let Some(attr) = attrs
                .get_attribute(Nl80211Attr::Ifname)
                .map(|a| a.nla_payload.as_ref())
            {
                if attr == ifname {
                    if let Some(ifindex) = attrs
                        .get_attribute(Nl80211Attr::Ifindex)
                        .map(|a| parse_ifindex(a.nla_payload.as_ref()))
                    {
                        return Ok(ifindex);
                    }
                }
            }
        }
    }

    return Err(NlError::new("no ifindex found"));
}

pub fn get_ssid(
    socket: &mut NlSocketHandle,
    nlid: u16,
    ifindex: u32,
) -> Result<Option<String>, NlError> {
    let mut attrs = GenlBuffer::new();
    attrs.push(Nlattr::new(
        None,
        false,
        false,
        Nl80211Attr::Ifindex.into(),
        Buffer::from(ifindex.to_ne_bytes().as_ref()),
    )?);

    let nlhdr = gen_nl80211_header(Nl80211Cmd::GetInterface, attrs, nlid, &[NlmF::Request]);
    socket.send(nlhdr)?;

    if let Some(msg) = socket.recv::<u16, Genlmsghdr<Nl80211Cmd, Nl80211Attr>>()? {
        if let Some(payload) = msg.nl_payload.get_payload() {
            let attrs = payload.get_attr_handle();

            if let Some(attr) = attrs.get_attribute(Nl80211Attr::Ssid) {
                return Ok(Some(
                    String::from_utf8_lossy(attr.nla_payload.as_ref()).to_string(),
                ));
            }
        }
    }

    Ok(None)
}
