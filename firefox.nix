{ wrapFirefox, firefox-unwrapped, fetchFirefoxAddon }:

wrapFirefox firefox-unwrapped {
  nixExtensions = [
    (fetchFirefoxAddon {
      name = "ublock-origin";
      url = "https://addons.mozilla.org/firefox/downloads/file/3679754/ublock_origin-1.31.0-an+fx.xpi";
      sha256 = "1h768ljlh3pi23l27qp961v1hd0nbj2vasgy11bmcrlqp40zgvnr";
    })
    (fetchFirefoxAddon {
      name = "lastpass";
      url = "https://addons.mozilla.org/firefox/downloads/file/3693247/lastpass_password_manager-4.62.0.6-an+fx.xpi";
      sha256 = "130kwpxf1m55rd6vikv54c62nbgx5immvhwigvg44i743w3cck2f";
    })
    (fetchFirefoxAddon {
      name = "https-everywhere";
      url = "https://addons.mozilla.org/firefox/downloads/file/3679479/https_everywhere-2020.11.17-an+fx.xpi";
      sha256 = "1jc5wccmjiaa2q1fhbnfilzz39pd68w5n2zwm7km8zk00l5cpsx6";
    })
    (fetchFirefoxAddon {
      name = "vuejs-devtools";
      url = "https://addons.mozilla.org/firefox/downloads/file/3454607/vuejs_devtools-5.3.3-fx.xpi";
      sha256 = "06ycn1bj00dh9klwg7bz23psgszcd02xp3668kfwvbbz9nnvvnsk";
    })
    (fetchFirefoxAddon {
      name = "cookie-auto-delete";
      url = "https://addons.mozilla.org/firefox/downloads/file/3630305/cookie_autodelete-3.5.1-an+fx.xpi";
      sha256 = "1v5b978kh8cxg4ckjb0mnnz2r5dngwp4i097i2lp7rf093jdv8vs";
    })
    (fetchFirefoxAddon {
      name = "firefox-containers";
      url = "https://addons.mozilla.org/firefox/downloads/file/3650825/firefox_multi_account_containers-7.1.0-fx.xpi";
      sha256 = "0iqcz9girvzg3dipyjvkr37q7q7a9l2ap1whakh9s6c36y660yxa";
    })
    (fetchFirefoxAddon{
      name = "user-agent-switcher";
      url = "https://addons.mozilla.org/firefox/downloads/file/3700959/user_agent_switcher_and_manager-0.4.6-an+fx.xpi";
      sha256 = "18cralk06i2ha6f23w2i1bvsq1ycwfbbv640965msb62qc59xxin";
    })
  ];
  extraPolicies = {
    CaptivePortal = false;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisableFirefoxAccounts = false;
    FirefoxHome = {
      Pocket = false;
      Snippets = false;
    };
    UserMessaging = {
      ExtensionRecommendations = false;
      SkipOnboarding = true;
    };
    DisableSetDesktopBackground = true;
  };
}
