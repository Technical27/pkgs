const Promise = require('bluebird');
const Module = require('./module');
const dns = require('dns');
const axios = require('axios');
const spawnSync = require('child_process').spawnSync;

const noInternet = () => {
  const sources = [
    dns.lookupAsync('one.one.one.one'),
    dns.lookupAsync('amazon.com'),
    dns.lookupAsync('google.com'),
  ];

  return Promise.any(sources)
    .timeout(5000)
    .then(() => true)
    .catch(Promise.TimeoutError, () => false)
    .catch((err) => {
      return err.code === dns.NOTFOUND ? false : err;
    });
};

const getLatestNixosVersion = () => {
  return axios('https://channels.nixos.org/nixos-unstable/git-revision').then(
    ({ data }) => data
  );
};

const getNixosVersion = async () => {
  return spawnSync('/run/current-system/sw/bin/nixos-version', ['--revision'])
    .stdout.toString()
    .trim();
};

class NixOSModule extends Module {
  constructor() {
    return noInternet()
      .then((online) => {
        if (!online) {
          return Promise.resolve(super('NixOS', ['offline']));
        } else {
          return Promise.all([getLatestNixosVersion(), getNixosVersion()]);
        }
      })
      .then((arr) => {
        if (arr instanceof Module) return arr;
        let [latestVersion, currentVersion] = arr;
        if (latestVersion === currentVersion) {
          return super('NixOS', ['No updates available']);
        } else {
          return super('NixOS', [
            `An update is available to: ${latestVersion.slice(0, 11)}`,
            'run `update` to update to the latest version',
          ]);
        }
      });
  }
}

module.exports = NixOSModule;
