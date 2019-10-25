library snowflake;

part 'config.dart';

int millisecond(int id, int epoch) {
  return id >> 22 + epoch;
}

int machine(int id) {
  return id >> 12 & 0x1f;
}

int dataCenter(int id) {
  return id >> 17 & 0x1f;
}

abstract class idWorker {
  factory idWorker(_config cfg) => _idWorker._(
      machine: cfg.machine & 0x1f,
      dataCenter: cfg.dataCenter & 0x1f,
      epoch: cfg.epoch);

  external int generate();
}

class _idWorker implements idWorker {
  final int machine;
  final int dataCenter;
  final int epoch;
  int sequence;
  int lastTimestamp;

  _idWorker._({this.machine, this.dataCenter, this.epoch})
      : sequence = 0,
        lastTimestamp = -1;

  int generate() {
    var timeGen = (int epoch) {
      return DateTime.now().millisecondsSinceEpoch - epoch;
    };

    var t = timeGen(this.epoch);
    if (t != this.lastTimestamp) {
      this.sequence = 0;
      this.lastTimestamp = t;
      var id = this.lastTimestamp << 22;
      id |= (this.dataCenter << 17);
      id |= (this.machine << 12);
      id |= this.sequence;

      return id;
    }

    this.sequence = (this.sequence + 1) & 0xfff;
    if (this.sequence == 0) {
      while (true) {
        t = timeGen(this.epoch);
        if (t > this.lastTimestamp) {
          break;
        }
      }
    }

    this.lastTimestamp = t;
    var id = this.lastTimestamp << 22;
    id |= (this.dataCenter << 17);
    id |= (this.machine << 12);
    id |= this.sequence;

    return id;
  }
}
