import 'package:snowflake/snowflake.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    idWorker worker;

    setUp(() {
      worker = idWorker(config(1, 2, 1288834974657));
    });

    test('First Test', () {
      var id = worker.generate();
      expect(machine(id), 1);
      expect(dataCenter(id), 2);
      print(id);
    });
  });
}
