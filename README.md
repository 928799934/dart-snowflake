snowflake for Dart

## Usage

A simple usage example:

```dart
import 'package:snowflake/snowflake.dart';

main() {
  var cfg = config(1,2,1288834974657);

  var worker = idWorker(cfg);
  print(worker.generate());
}
```
