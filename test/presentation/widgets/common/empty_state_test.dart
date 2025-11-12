import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vpp_flutter_port/presentation/widgets/common/empty_state.dart';

void main() {
  group('EmptyState Widget Tests', () {
    testWidgets('displays title and message', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              title: 'No Workouts',
              message: 'You haven\'t completed any workouts yet.',
            ),
          ),
        ),
      );

      expect(find.text('No Workouts'), findsOneWidget);
      expect(find.text('You haven\'t completed any workouts yet.'), findsOneWidget);
    });

    testWidgets('displays custom icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              icon: Icons.inbox,
              title: 'Empty',
              message: 'No items',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.inbox), findsOneWidget);
    });

    testWidgets('displays action button when actionLabel and onAction provided', (WidgetTester tester) async {
      bool actionCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              title: 'No Workouts',
              message: 'Start your first workout',
              actionLabel: 'Get Started',
              onAction: () {
                actionCalled = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Get Started'), findsOneWidget);
      
      await tester.tap(find.text('Get Started'));
      await tester.pump();
      
      expect(actionCalled, isTrue);
    });

    testWidgets('does not display action button when actionLabel is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              title: 'No Workouts',
              message: 'No items',
              onAction: () {},
            ),
          ),
        ),
      );

      expect(find.byType(FilledButton), findsNothing);
    });

    testWidgets('does not display action button when onAction is null', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              title: 'No Workouts',
              message: 'No items',
              actionLabel: 'Action',
            ),
          ),
        ),
      );

      expect(find.byType(FilledButton), findsNothing);
    });

    testWidgets('uses default fitness center icon when not specified', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: EmptyState(
              title: 'Empty',
              message: 'No items',
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.fitness_center), findsOneWidget);
    });
  });
}
