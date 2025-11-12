import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vpp_flutter_port/presentation/widgets/workout/countdown_card.dart';
import 'package:vpp_flutter_port/presentation/widgets/workout/rest_timer_card.dart';
import 'package:vpp_flutter_port/presentation/widgets/workout/set_summary_card.dart';
import 'package:vpp_flutter_port/domain/models/workout_metric.dart';
import 'package:vpp_flutter_port/domain/models/weight_unit.dart';

void main() {
  group('CountdownCard', () {
    testWidgets('displays countdown number correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountdownCard(secondsRemaining: 5),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);
      expect(find.text('Get Ready!'), findsOneWidget);
      expect(find.text('Starting in...'), findsOneWidget);
    });

    testWidgets('updates countdown number when secondsRemaining changes',
        (WidgetTester tester) async {
      int secondsRemaining = 5;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountdownCard(secondsRemaining: secondsRemaining),
          ),
        ),
      );

      expect(find.text('5'), findsOneWidget);

      // Update countdown
      secondsRemaining = 3;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountdownCard(secondsRemaining: secondsRemaining),
          ),
        ),
      );

      expect(find.text('3'), findsOneWidget);
      expect(find.text('5'), findsNothing);
    });

    testWidgets('has pulsing animation', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CountdownCard(secondsRemaining: 5),
          ),
        ),
      );

      // Verify animation controller exists by checking for ScaleTransition
      expect(find.byType(ScaleTransition), findsWidgets);

      // Pump animation frames
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pump(const Duration(milliseconds: 600));
    });
  });

  group('RestTimerCard', () {
    String formatWeight(double kg, WeightUnit unit) {
      final value = unit == WeightUnit.kg ? kg : kg * 2.20462;
      final unitSuffix = unit == WeightUnit.kg ? 'kg' : 'lb';
      return '${value.toStringAsFixed(1)} $unitSuffix';
    }

    testWidgets('displays rest timer correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestTimerCard(
              secondsRemaining: 60,
              totalSeconds: 90,
              nextExerciseName: 'Bench Press',
              isLastExercise: false,
              currentSet: 1,
              totalSets: 3,
              onSkip: () {},
            ),
          ),
        ),
      );

      expect(find.text('REST TIME'), findsOneWidget);
      expect(find.text('1:00'), findsOneWidget);
      expect(find.text('UP NEXT'), findsOneWidget);
      expect(find.text('Bench Press'), findsOneWidget);
      expect(find.text('Set 1 of 3'), findsOneWidget);
      expect(find.text('Skip Rest'), findsOneWidget);
    });

    testWidgets('formats time as MM:SS correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestTimerCard(
              secondsRemaining: 125,
              totalSeconds: 180,
              nextExerciseName: 'Squat',
              isLastExercise: false,
              currentSet: 2,
              totalSets: 4,
              onSkip: () {},
            ),
          ),
        ),
      );

      expect(find.text('2:05'), findsOneWidget);
    });

    testWidgets('shows workout complete for last exercise',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestTimerCard(
              secondsRemaining: 30,
              totalSeconds: 60,
              nextExerciseName: 'Final Exercise',
              isLastExercise: true,
              currentSet: 3,
              totalSets: 3,
              onSkip: () {},
            ),
          ),
        ),
      );

      expect(find.text('Workout Complete'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
      expect(find.text('Set 3 of 3'), findsNothing);
    });

    testWidgets('displays workout parameters when provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestTimerCard(
              secondsRemaining: 45,
              totalSeconds: 60,
              nextExerciseName: 'Deadlift',
              isLastExercise: false,
              currentSet: 1,
              totalSets: 3,
              nextExerciseWeight: 100.0,
              nextExerciseReps: 10,
              nextExerciseMode: 'Eccentric',
              formatWeight: formatWeight,
              onSkip: () {},
            ),
          ),
        ),
      );

      expect(find.text('WORKOUT PARAMETERS'), findsOneWidget);
      expect(find.text('Weight'), findsOneWidget);
      expect(find.text('Target Reps'), findsOneWidget);
      expect(find.text('Mode'), findsOneWidget);
    });

    testWidgets('calls onSkip when skip button is pressed',
        (WidgetTester tester) async {
      bool skipCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestTimerCard(
              secondsRemaining: 30,
              totalSeconds: 60,
              nextExerciseName: 'Exercise',
              isLastExercise: false,
              currentSet: 1,
              totalSets: 3,
              onSkip: () {
                skipCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Skip Rest'));
      await tester.pump();

      expect(skipCalled, isTrue);
    });

    testWidgets('shows circular progress indicator', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestTimerCard(
              secondsRemaining: 30,
              totalSeconds: 60,
              nextExerciseName: 'Exercise',
              isLastExercise: false,
              currentSet: 1,
              totalSets: 3,
              onSkip: () {},
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays exercise progress for multi-exercise routines',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RestTimerCard(
              secondsRemaining: 30,
              totalSeconds: 60,
              nextExerciseName: 'Exercise',
              isLastExercise: false,
              currentSet: 1,
              totalSets: 3,
              currentExerciseIndex: 2,
              totalExercises: 5,
              onSkip: () {},
            ),
          ),
        ),
      );

      expect(find.text('Exercise 3 of 5'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });
  });

  group('SetSummaryCard', () {
    String formatWeight(double kg, WeightUnit unit) {
      final value = unit == WeightUnit.kg ? kg : kg * 2.20462;
      final unitSuffix = unit == WeightUnit.kg ? 'kg' : 'lb';
      return '${value.toStringAsFixed(1)} $unitSuffix';
    }

    List<WorkoutMetric> createTestMetrics() {
      final now = DateTime.now().millisecondsSinceEpoch;
      return List.generate(10, (index) {
        return WorkoutMetric(
          timestamp: now + (index * 100),
          loadA: 50.0 + (index * 5.0),
          loadB: 50.0 + (index * 5.0),
          positionA: 1000 + index * 10,
          positionB: 1000 + index * 10,
          power: 100.0 + (index * 10.0),
        );
      });
    }

    testWidgets('displays set completion header', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SetSummaryCard(
              metrics: createTestMetrics(),
              peakPower: 150.0,
              averagePower: 120.0,
              repCount: 10,
              weightUnit: WeightUnit.kg,
              formatWeight: formatWeight,
              onContinue: () {},
            ),
          ),
        ),
      );

      expect(find.text('Set Complete!'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('displays PR badge when isPR is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SetSummaryCard(
              metrics: createTestMetrics(),
              peakPower: 150.0,
              averagePower: 120.0,
              repCount: 10,
              weightUnit: WeightUnit.kg,
              formatWeight: formatWeight,
              onContinue: () {},
              isPR: true,
            ),
          ),
        ),
      );

      expect(find.text('PR!'), findsOneWidget);
    });

    testWidgets('displays stats correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SetSummaryCard(
              metrics: createTestMetrics(),
              peakPower: 150.0,
              averagePower: 120.0,
              repCount: 10,
              weightUnit: WeightUnit.kg,
              formatWeight: formatWeight,
              onContinue: () {},
            ),
          ),
        ),
      );

      expect(find.text('Peak'), findsOneWidget);
      expect(find.text('Average'), findsOneWidget);
      expect(find.text('Reps'), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
      expect(find.text('150.0 kg'), findsOneWidget);
      expect(find.text('120.0 kg'), findsOneWidget);
    });

    testWidgets('displays force graph when metrics are provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SetSummaryCard(
              metrics: createTestMetrics(),
              peakPower: 150.0,
              averagePower: 120.0,
              repCount: 10,
              weightUnit: WeightUnit.kg,
              formatWeight: formatWeight,
              onContinue: () {},
            ),
          ),
        ),
      );

      expect(find.text('Force Over Time'), findsOneWidget);
    });

    testWidgets('hides force graph when metrics are empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SetSummaryCard(
              metrics: [],
              peakPower: 150.0,
              averagePower: 120.0,
              repCount: 10,
              weightUnit: WeightUnit.kg,
              formatWeight: formatWeight,
              onContinue: () {},
            ),
          ),
        ),
      );

      expect(find.text('Force Over Time'), findsNothing);
    });

    testWidgets('calls onContinue when continue button is pressed',
        (WidgetTester tester) async {
      bool continueCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SetSummaryCard(
              metrics: createTestMetrics(),
              peakPower: 150.0,
              averagePower: 120.0,
              repCount: 10,
              weightUnit: WeightUnit.kg,
              formatWeight: formatWeight,
              onContinue: () {
                continueCalled = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Continue'));
      await tester.pump();

      expect(continueCalled, isTrue);
    });

    testWidgets('formats weight correctly for different units',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SetSummaryCard(
              metrics: createTestMetrics(),
              peakPower: 100.0,
              averagePower: 90.0,
              repCount: 8,
              weightUnit: WeightUnit.lb,
              formatWeight: formatWeight,
              onContinue: () {},
            ),
          ),
        ),
      );

      // Should show weight in pounds
      expect(find.textContaining('lb'), findsWidgets);
    });
  });
}
