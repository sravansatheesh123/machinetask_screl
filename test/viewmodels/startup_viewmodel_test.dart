import 'package:flutter_test/flutter_test.dart';
import 'package:machinetask_scarel/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('StartupViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
