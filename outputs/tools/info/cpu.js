const Module = require('./module');
const si = require('systeminformation');

class CPUModule extends Module {
  constructor() {
    return Promise.all([
      si.cpuTemperature(),
      si.cpuCurrentSpeed(),
    ]).then(([temp, speed]) =>
      super('CPU', [`${Math.floor(temp.main)}C, ${speed.avg}GHz`])
    );
  }
}

module.exports = CPUModule;
