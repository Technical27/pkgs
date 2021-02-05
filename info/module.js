class Module {
  constructor(title, data) {
    this.title = title;
    this.data = data;
  }

  static _write(str) {
    process.stdout.write(str);
  }

  static _writei(str) {
    Module._write(`  ${str}\n`);
  }

  display() {
    Module._write(`${this.title}:\n`);
    for (const x of this.data) {
      Module._writei(x.toString());
    }
  }
}

module.exports = Module;
