const Module = require('./module');
const spawnSync = require('child_process').spawnSync;

const findRule = (rule) => {
  return (
    rule.fwmark == '0xc738' &&
    rule.src == 'all' &&
    rule.table == '1000' &&
    rule.not == null
  );
};

const vpnConnected = async () => {
  return Promise.all([getRules(false), getRules(true)]).then(([ipv4, ipv6]) => {
    const ipv4Rules = JSON.parse(ipv4);
    const ipv6Rules = JSON.parse(ipv6);
    return ipv4Rules.some(findRule) && ipv6Rules.some(findRule);
  });
};

const getRules = async (ipv6) => {
  return spawnSync('ip', ['-j', ipv6 ? '-6' : '-4', 'rule', 'list'])
    .stdout.toString()
    .trim();
};

class WGModule extends Module {
  constructor() {
    return vpnConnected().then((connected) =>
      super('VPN', [connected ? 'Connected' : 'Disconnected'])
    );
  }
}

module.exports = WGModule;
