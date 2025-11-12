// Basic Flutter widget smoke test for VPP Flutter Port

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vpp_flutter_port/presentation/app.dart';

void main() {
  testWidgets('VPP App widget can be created', (WidgetTester tester) async {
    // Just verify we can create the widget without crashing
    const app = VPPApp();

    expect(app, isNotNull);
    expect(app, isA<ConsumerWidget>());
  });
}
