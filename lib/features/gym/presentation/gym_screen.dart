import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dashboard/presentation/widgets/summary_card.dart';
import '../data/gym_notifier.dart';
import 'widgets/workout_tile.dart';

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
          backgroundColor: const Color(0xFF1E1E1E),
          title: const Text('Add Workout', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: exerciseController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: 'Exercise'),
              ),
              TextField(
                controller: setsController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Sets'),
              ),
              TextField(
                controller: repsController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Reps'),
              ),
              TextField(
                controller: caloriesController,
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Calories burned'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddWorkoutDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Gym Dashboard',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.fitness_center,
                      title: 'Status',
                      value: status,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SummaryCard(
                      icon: Icons.local_fire_department,
                      title: 'Calories',
                      value: '$calories kcal',
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Recent Workouts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              if (workouts.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text('No workouts yet. Tap + to add one.', style: TextStyle(color: Colors.grey[500])),
                ),
              for (final workout in workouts)
                WorkoutTile(
                  exercise: workout.exercise,
                  detail: '${workout.sets}x${workout.reps}',
                  onDelete: () => ref.read(gymProvider.notifier).deleteWorkout(workout.id!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}