mod dns;
mod rule;
mod wifi;

use dbus::blocking::{Connection, Proxy};
use dns::{connect_dbus, get_network1_proxy, set_domains};
use neli::socket::NlSocketHandle;
use rule::{connect_rtnetlink, disable_rules, enable_rules};
use wifi::{connect_genl, get_ifindex, get_ssid};

use std::thread::sleep;
use std::time::Duration;

use std::sync::atomic::{AtomicBool, Ordering};
use std::sync::Arc;

fn enable_vpn(rtsocket: &mut NlSocketHandle, proxy: &Proxy<&Connection>, wg_ifindex: i32) {
    println!("enabling");
    if let Err(e) = enable_rules(rtsocket) {
        eprintln!("failed to enable rules: {}", e);
    }
    if let Err(e) = set_domains(&proxy, wg_ifindex, &[""]) {
        eprintln!("failed to set dns domain: {}", e);
    }
}

fn disable_vpn(rtsocket: &mut NlSocketHandle, proxy: &Proxy<&Connection>, wg_ifindex: i32) {
    println!("disabling");
    disable_rules(rtsocket).unwrap();
    set_domains(&proxy, wg_ifindex, &[]).unwrap();
}

fn main() {
    let mut nlsocket = connect_genl().unwrap();
    let nlid = nlsocket.resolve_genl_family("nl80211").unwrap();
    let wlan_ifindex = get_ifindex(&mut nlsocket, nlid, b"wlan0\0").unwrap();

    let mut rtsocket = connect_rtnetlink().unwrap();

    let dbus_conn = connect_dbus().unwrap();
    let dbus_proxy = get_network1_proxy(&dbus_conn);

    let wg_ifindex = dns::get_ifindex(&dbus_proxy, "wg0").unwrap() as i32;

    let running = Arc::new(AtomicBool::new(true));
    let r = running.clone();

    ctrlc::set_handler(move || {
        r.store(false, Ordering::SeqCst);
    })
    .expect("Error setting Ctrl-C handler");

    let mut enabled = false;
    while running.load(Ordering::SeqCst) {
        if enabled {
            enable_rules(rtsocket).unwrap();
        }

        if let Ok(ssid) = get_ssid(&mut nlsocket, nlid, wlan_ifindex) {
            if let Some(ssid) = ssid {
                if (ssid != "JAY5" && ssid != "JAY2") && !enabled {
                    enabled = true;
                    enable_vpn(&mut rtsocket, &dbus_proxy, wg_ifindex);
                } else if (ssid == "JAY5" || ssid == "JAY2") && enabled {
                    enabled = false;
                    disable_vpn(&mut rtsocket, &dbus_proxy, wg_ifindex);
                }
            } else if enabled {
                enabled = false;
                disable_vpn(&mut rtsocket, &dbus_proxy, wg_ifindex);
            }
        }
        sleep(Duration::from_secs(5));
    }

    println!("exiting...");
    disable_vpn(&mut rtsocket, &dbus_proxy, wg_ifindex);
}
