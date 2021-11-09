use neli::consts::nl::{NlmF, NlmFFlags};
use neli::consts::rtnl::Rtm;
use neli::consts::rtnl::{RtAddrFamily, Rta, RtmF, RtmFFlags};
use neli::consts::socket::NlFamily;
use neli::err::NlError;
use neli::nl::{NlPayload, Nlmsghdr};
use neli::rtnl::{Rtattr, Rtmsg};
use neli::socket::NlSocketHandle;
use neli::types::{Buffer, NlBuffer, RtBuffer};

pub fn connect_rtnetlink() -> Result<NlSocketHandle, std::io::Error> {
    NlSocketHandle::connect(NlFamily::Route, None, &[])
}

fn gen_attrs() -> RtBuffer<Rta, Buffer> {
    let mut buf = RtBuffer::new();
    buf.push(Rtattr {
        rta_len: 5,
        rta_type: Rta::Src,
        rta_payload: Buffer::from(vec![0]),
    });
    buf.push(Rtattr {
        rta_len: 8,
        rta_type: Rta::Protoinfo,
        rta_payload: Buffer::from(51000_u32.to_ne_bytes().to_vec()),
    });
    buf.push(Rtattr {
        rta_len: 8,
        rta_type: Rta::Mark,
        rta_payload: Buffer::from(vec![255, 255, 255, 255]),
    });
    buf.push(Rtattr {
        rta_len: 8,
        rta_type: Rta::Table,
        rta_payload: Buffer::from(1000_u32.to_ne_bytes().to_vec()),
    });

    buf
}

fn gen_msg(family: RtAddrFamily) -> Rtmsg {
    Rtmsg {
        rtm_family: family,
        rtm_dst_len: 0,
        rtm_src_len: 0,
        rtm_tos: 0,
        rtm_table: neli::consts::rtnl::RtTable::Default,
        rtm_protocol: neli::consts::rtnl::Rtprot::Unspec,
        rtm_scope: neli::consts::rtnl::RtScope::Universe,
        rtm_type: neli::consts::rtnl::Rtn::Unicast,
        rtm_flags: RtmFFlags::new(&[RtmF::UnrecognizedVariant(2)]),
        rtattrs: gen_attrs(),
    }
}

fn gen_hdr(family: RtAddrFamily, rtm: Rtm, flags: &[NlmF]) -> Nlmsghdr<Rtm, Rtmsg> {
    let msg = gen_msg(family);
    Nlmsghdr::new(
        None,
        rtm,
        NlmFFlags::new(flags),
        None,
        None,
        NlPayload::Payload(msg),
    )
}

fn add_rule(socket: &mut NlSocketHandle, family: RtAddrFamily) -> Result<(), NlError> {
    if !check_rules(socket, family)? {
        return socket.send(gen_hdr(
            family,
            Rtm::Newrule,
            &[NlmF::Request, NlmF::Create],
        ));
    }

    Ok(())
}

fn remove_rule(socket: &mut NlSocketHandle, family: RtAddrFamily) -> Result<(), NlError> {
    if check_rules(socket, family)? {
        return socket.send(gen_hdr(
            family,
            Rtm::Delrule,
            &[NlmF::Request, NlmF::Create],
        ));
    }

    Ok(())
}

pub fn enable_rules(socket: &mut NlSocketHandle) -> Result<(), NlError> {
    add_rule(socket, RtAddrFamily::Inet).and_then(|_| add_rule(socket, RtAddrFamily::Inet6))
}

pub fn disable_rules(socket: &mut NlSocketHandle) -> Result<(), NlError> {
    remove_rule(socket, RtAddrFamily::Inet).and_then(|_| remove_rule(socket, RtAddrFamily::Inet6))
}

pub fn check_rules(socket: &mut NlSocketHandle, family: RtAddrFamily) -> Result<bool, NlError> {
    socket.send(gen_hdr(family, Rtm::Getrule, &[NlmF::Request, NlmF::Match]))?;

    let msgs: NlBuffer<Rtm, Rtmsg> = socket.recv_all()?;

    for msg in msgs {
        if let Some(payload) = msg.nl_payload.get_payload() {
            for attr in payload.rtattrs.iter() {
                if attr.rta_type == Rta::Table {
                    let mut num: [u8; 4] = Default::default();
                    num.copy_from_slice(attr.rta_payload.as_ref());
                    if u32::from_ne_bytes(num) == 1000 {
                        return Ok(true);
                    }
                }
            }
        }
    }

    Ok(false)
}
