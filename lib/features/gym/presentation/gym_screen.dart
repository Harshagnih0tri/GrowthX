import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dashboard/presentation/widgets/summary_card.dart';
import '../data/gym_notifier.dart';
import 'widgets/workout_tile.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';

class GymScreen extends ConsumerWidget {
  const GymScreen({super.key});

  void _showAddWorkoutDialog(BuildContext context, WidgetRef ref) {
    final exerciseController = TextEditingController();
    final setsController = TextEditingController();
    final repsController = TextEditingController();
    final caloriesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Workout'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: exerciseController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Exercise'),
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: setsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Sets'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: TextField(
                      controller: repsController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Reps'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: caloriesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Calories burned'),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                final exercise = exerciseController.text.trim();
                final sets = int.tryParse(setsController.text.trim()) ?? 0;
                final reps = int.tryParse(repsController.text.trim()) ?? 0;
                final calories = int.tryParse(caloriesController.text.trim()) ?? 0;
                if (exercise.isNotEmpty && sets > 0 && reps > 0) {
                  ref.read(gymProvider.notifier).addWorkout(exercise, sets, reps, calories);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(gymProvider);
    final status = ref.watch(todayWorkoutStatusProvider);
    final calories = ref.watch(todayCaloriesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Gym')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddWorkoutDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Log Workout'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xxl,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(title: 'Today'),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.fitness_center_rounded,
                      title: 'Status',
                      value: status,
                      color: AppColors.gym,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.local_fire_department_rounded,
                      title: 'Calories',
                      value: '$calories kcal',
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              const SectionHeader(title: 'Recent Workouts'),
              const SizedBox(height: AppSpacing.md),
              if (workouts.isEmpty)
                const EmptyState(
                  icon: Icons.fitness_center_rounded,
                  title: 'No workouts logged',
                  subtitle: 'Tap "Log Workout" to track your training',
                )
              else
                for (final workout in workouts)
                  WorkoutTile(
                    exercise: workout.exercise,
                    detail: '${workout.sets}x${workout.reps}',
                    calories: '${workout.caloriesBurned}',
                    onDelete: () => ref.read(gymProvider.notifier).deleteWorkout(workout.id!),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}