#!/usr/bin/env node

const Promise = require('bluebird');
const si = require('systeminformation');
const axios = require('axios');
const fs = Promise.promisifyAll(require('fs'));
const dns = Promise.promisifyAll(require('dns'));
const spawnSync = require('child_process').spawnSync;
const CPUModule = require('./cpu');
const DiskModule = require('./disks');
const WGModule = require('./wg');
const NixOSModule = require('./nixos');

const noInternet = () => {
  const sources = [
    dns.lookupAsync('one.one.one.one'),
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

const getLatestNixosVersion = async () => {
  let { data } = await axios(
    'https://channels.nixos.org/nixos-unstable/git-revision'
  );
  return data;
};

const getNixosVersion = async () => {
  return spawnSync('nixos-version', ['--revision']).stdout.toString().trim();
};

const convertBytes = (bytes) => {
  const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];

  const i =
    parseInt(Math.floor(Math.log(bytes) / Math.log(1024))) % (sizes.length - 1);
  const size = sizes[i];

  if (i === 0) {
    return `${bytes} ${size}`;
  }

  return `${(bytes / Math.pow(1024, i)).toFixed(2)} ${size}`;
};

const main = () => {
  return Promise.all([
    new DiskModule(),
    new CPUModule(),
    new WGModule(),
    new NixOSModule(),
  ]).then((modules) => {
    modules.forEach((m) => m.display());
  });
};

const JSONLog = (obj) => console.log(JSON.stringify(obj));

if (process.argv[2] == '--waybar') {
  noInternet()
    .then((online) => {
      if (!online) {
        JSONLog({ text: '', tooltip: 'offline', class: 'offline' });
        return process.exit();
      } else {
        return Promise.all([getLatestNixosVersion(), getNixosVersion()]);
      }
    })
    .then(([latestVersion, currentVersion]) => {
      if (latestVersion == currentVersion) {
        JSONLog({
          text: '',
          tooltip: `currently on the latest version ${currentVersion.slice(
            0,
            11
          )}`,
          class: 'updated',
        });
      } else {
        JSONLog({
          text: '',
          tooltip: `an update is available to ${latestVersion.slice(0, 11)}`,
          class: 'update-available',
        });
      }
    })
    .catch((err) => JSONLog({ text: '', tooltip: err, class: 'error' }));
} else if (process.argv[2] == '--polybar') {
  noInternet()
    .then((online) => {
      if (!online) {
        console.log('%{F#FB4934} offline%{F-}');
      } else {
        return Promise.all([getLatestNixosVersion(), getNixosVersion()]);
      }
    })
    .then(([latestVersion, currentVersion]) => {
      if (latestVersion === currentVersion) {
        console.log('%{F#EBDBB2}%{F-}');
      } else {
        console.log('%{F#FABD2F}%{F-}');
      }
    })
    .catch((err) => console.log('%{F#FB4934}%{F-} ' + err));
} else {
  main().catch((err) => console.error(`Error running: ${err}`));
}
