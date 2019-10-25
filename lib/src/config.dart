part of 'snowflake_base.dart';

abstract class config {
  factory config(int machine, int dataCenter, int epoch) =>
      _config._(machine: machine, dataCenter: dataCenter, epoch: epoch);
}

class _config implements config {
  final int machine;
  final int dataCenter;
  final int epoch;
  _config._({this.machine, this.dataCenter, this.epoch});
}
