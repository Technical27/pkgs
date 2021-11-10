const Module = require('./module');
const si = require('systeminformation');

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

class DiskModule extends Module {
  constructor() {
    return si.fsSize().then((disks) => {
      return super(
        'Disks',
        disks.map(
          (d) =>
            `${d.fs} -> ${d.mount}: ${convertBytes(d.used)} used, ${Math.floor(
              100 - d.use
            )}% free`
        )
      );
    });
  }
}

module.exports = DiskModule;
