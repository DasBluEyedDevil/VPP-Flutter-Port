// Basic Flutter widget smoke test for VPP Flutter Port

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vpp_flutter_port/presentation/app.dart';

void main() {
  testWidgets('VPP App builds without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const ProviderScope(child: VPPApp()));

    // Verify the app renders
    expect(find.byType(VPPApp), findsOneWidget);
  });
}
