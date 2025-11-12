// Basic Flutter widget smoke test for VPP Flutter Port

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:vpp_flutter_port/main.dart';

void main() {
  testWidgets('VPP App builds without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(const ProviderScope(child: VPPApp()));

    // Verify that the app title is present
    expect(find.text('Vitruvian Project Phoenix'), findsOneWidget);

    // Verify phase completion message
    expect(find.text('Phase 0: Setup Complete'), findsOneWidget);

    // Verify app bar title
    expect(find.text('VPP Flutter Port'), findsOneWidget);

    // Verify fitness icon is present
    expect(find.byIcon(Icons.fitness_center), findsOneWidget);
  });
}
