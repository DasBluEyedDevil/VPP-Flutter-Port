import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vpp_flutter_port/presentation/widgets/inputs/compact_number_picker.dart';
import 'package:vpp_flutter_port/presentation/widgets/inputs/custom_number_picker.dart';
import 'package:vpp_flutter_port/presentation/theme/theme.dart';
import 'package:vpp_flutter_port/presentation/theme/colors.dart';

void main() {
  group('CompactNumberPicker', () {
    testWidgets('displays label and value with suffix', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: CompactNumberPicker(
              label: 'Weight',
              value: 10,
              min: 0,
              max: 100,
              suffix: 'kg',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Weight'), findsOneWidget);
      expect(find.text('10 kg'), findsOneWidget);
    });

    testWidgets('displays value without suffix when suffix is empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: CompactNumberPicker(
              label: 'Count',
              value: 10,
              min: 0,
              max: 100,
              suffix: '',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('10'), findsOneWidget);
    });

    testWidgets('increments value when plus button is tapped', (WidgetTester tester) async {
      int? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: CompactNumberPicker(
              label: 'Count',
              value: 10,
              min: 0,
              max: 100,
              suffix: '',
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      final incrementButton = find.byIcon(Icons.add);
      expect(incrementButton, findsOneWidget);

      await tester.tap(incrementButton);
      await tester.pumpAndSettle();

      expect(selectedValue, equals(11));
    });

    testWidgets('decrements value when minus button is tapped', (WidgetTester tester) async {
      int? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: CompactNumberPicker(
              label: 'Count',
              value: 10,
              min: 0,
              max: 100,
              suffix: '',
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      final decrementButton = find.byIcon(Icons.remove);
      expect(decrementButton, findsOneWidget);

      await tester.tap(decrementButton);
      await tester.pumpAndSettle();

      expect(selectedValue, equals(9));
    });

    testWidgets('enforces min bound - decrement button disabled at min', (WidgetTester tester) async {
      int? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: CompactNumberPicker(
              label: 'Count',
              value: 0,
              min: 0,
              max: 100,
              suffix: '',
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      final decrementButton = find.byIcon(Icons.remove);
      await tester.tap(decrementButton);
      await tester.pumpAndSettle();

      // Value should not change
      expect(selectedValue, isNull);
    });

    testWidgets('enforces max bound - increment button disabled at max', (WidgetTester tester) async {
      int? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: CompactNumberPicker(
              label: 'Count',
              value: 100,
              min: 0,
              max: 100,
              suffix: '',
              onChanged: (value) => selectedValue = value,
            ),
          ),
        ),
      );

      final incrementButton = find.byIcon(Icons.add);
      await tester.tap(incrementButton);
      await tester.pumpAndSettle();

      // Value should not change
      expect(selectedValue, isNull);
    });

    testWidgets('displays integer values correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: CompactNumberPicker(
              label: 'Count',
              value: 10,
              min: 0,
              max: 100,
              suffix: '',
              onChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('10'), findsOneWidget);
    });
  });

  group('CustomNumberPicker', () {
    testWidgets('displays current value with unit', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: SizedBox(
              height: 250,
              child: CustomNumberPicker(
                value: 10.5,
                min: 0.0,
                max: 100.0,
                step: 0.5,
                unit: 'kg',
                onChange: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('10.5 kg'), findsOneWidget);
    });

    testWidgets('calls onChange when value changes via scroll', (WidgetTester tester) async {
      double? selectedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: SizedBox(
              height: 250,
              child: CustomNumberPicker(
                value: 10.0,
                min: 0.0,
                max: 20.0,
                step: 1.0,
                onChange: (value) => selectedValue = value,
              ),
            ),
          ),
        ),
      );

      // Find the scrollable and scroll it
      final scrollable = find.byType(ListWheelScrollView);
      expect(scrollable, findsOneWidget);
      
      // Scroll down by dragging
      await tester.drag(scrollable, const Offset(0, -50));
      await tester.pumpAndSettle();

      // Value should have changed (may be 11 or 12 depending on scroll)
      expect(selectedValue, isNotNull);
      expect(selectedValue! >= 10.0 && selectedValue! <= 20.0, isTrue);
    });

    testWidgets('enforces min bound', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: SizedBox(
              height: 250,
              child: CustomNumberPicker(
                value: 0.0,
                min: 0.0,
                max: 100.0,
                step: 1.0,
                onChange: (_) {},
              ),
            ),
          ),
        ),
      );

      // Should display min value
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('enforces max bound', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: SizedBox(
              height: 250,
              child: CustomNumberPicker(
                value: 100.0,
                min: 0.0,
                max: 100.0,
                step: 1.0,
                onChange: (_) {},
              ),
            ),
          ),
        ),
      );

      // Should display max value
      expect(find.text('100'), findsOneWidget);
    });

    testWidgets('supports decimal steps (0.5 increments)', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: SizedBox(
              height: 250,
              child: CustomNumberPicker(
                value: 10.0,
                min: 0.0,
                max: 20.0,
                step: 0.5,
                onChange: (_) {},
              ),
            ),
          ),
        ),
      );

      // Should display values with 0.5 steps
      expect(find.text('10'), findsOneWidget);
      expect(find.text('10.5'), findsOneWidget);
    });

    testWidgets('displays whole numbers without decimal point', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: SizedBox(
              height: 250,
              child: CustomNumberPicker(
                value: 10.0,
                min: 0.0,
                max: 20.0,
                step: 1.0,
                onChange: (_) {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('10'), findsOneWidget);
      expect(find.text('10.0'), findsNothing);
    });

    testWidgets('disables scrolling when enabled is false', (WidgetTester tester) async {
      double? selectedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          theme: getAppTheme(darkColorScheme),
          home: Scaffold(
            body: SizedBox(
              height: 250,
              child: CustomNumberPicker(
                value: 10.0,
                min: 0.0,
                max: 20.0,
                step: 1.0,
                enabled: false,
                onChange: (value) => selectedValue = value,
              ),
            ),
          ),
        ),
      );

      final scrollable = find.byType(ListWheelScrollView);
      await tester.drag(scrollable, const Offset(0, -50));
      await tester.pumpAndSettle();

      // Value should not change when disabled
      expect(selectedValue, isNull);
    });
  });
}
