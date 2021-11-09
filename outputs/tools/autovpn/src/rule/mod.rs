use neli::consts::nl::{NlmF, NlmFFlags};
use neli::consts::rtnl::Rtm;
use neli::consts::rtnl::{RtAddrFamily, Rta, RtmF, RtmFFlags};
use neli::consts::socket::NlFamily;
use neli::err::NlError;
use neli::nl::{NlPayload, Nlmsghdr};
use neli::rtnl::{Rtattr, Rtmsg};
use neli::socket::NlSocketHandle;
use neli::types::{Buffer, RtBuffer};

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
    socket.send(gen_hdr(
        family,
        Rtm::Newrule,
        &[NlmF::Request, NlmF::Create],
    ))
}

fn remove_rule(socket: &mut NlSocketHandle, family: RtAddrFamily) -> Result<(), NlError> {
    socket.send(gen_hdr(
        family,
        Rtm::Delrule,
        &[NlmF::Request, NlmF::Create],
    ))
}

pub fn enable_rules(socket: &mut NlSocketHandle) -> Result<(), NlError> {
    add_rule(socket, RtAddrFamily::Inet).and_then(|_| add_rule(socket, RtAddrFamily::Inet6))
}

pub fn disable_rules(socket: &mut NlSocketHandle) -> Result<(), NlError> {
    remove_rule(socket, RtAddrFamily::Inet).and_then(|_| remove_rule(socket, RtAddrFamily::Inet6))
}
