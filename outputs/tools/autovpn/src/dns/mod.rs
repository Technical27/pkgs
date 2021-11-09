use dbus::blocking::{Connection, Proxy};
use std::time::Duration;

pub fn connect_dbus() -> Result<Connection, dbus::Error> {
    Connection::new_system()
}

pub fn get_network1_proxy(conn: &Connection) -> Proxy<&Connection> {
    conn.with_proxy(
        "org.freedesktop.network1",
        "/org/freedesktop/network1",
        Duration::from_secs(2),
    )
}

pub fn get_ifindex(proxy: &Proxy<&Connection>, ifname: &str) -> Result<i32, dbus::Error> {
    let (ifindex,) = proxy.method_call(
        "org.freedesktop.network1.Manager",
        "GetLinkByName",
        (ifname,),
    )?;

    Ok(ifindex)
}

pub fn set_domains(
    proxy: &Proxy<&Connection>,
    ifindex: i32,
    domains: &[&str],
) -> Result<(), dbus::Error> {
    // let proxy = conn.with_proxy(
    //     "org.freedesktop.resolve1",
    //     "/org/freedesktop/resolve1",
    //     Duration::from_secs(2),
    // );
    // let x: (Path,) = proxy
    //     .method_call("org.freedesktop.resolve1.Manager", "GetLink", (2i32,))
    //     .unwrap();
    // println!("{}", x.0);
    //("~.", true)
    let domains = domains.iter().map(|s| (*s, true)).collect::<Vec<_>>();
    proxy.method_call(
        "org.freedesktop.network1.Manager",
        "SetLinkDomains",
        (ifindex, domains),
    )
}
