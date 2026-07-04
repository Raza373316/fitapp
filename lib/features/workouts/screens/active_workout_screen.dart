import 'dart:async';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../data/models/exercise_model.dart';
class ActiveWorkoutScreen extends StatefulWidget {
  final ExerciseModel exercise;
  const ActiveWorkoutScreen({super.key, required this.exercise});

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  Timer? _timer;
  int _elapsedSeconds = 0;
  int _currentSet = 1;
  bool _resting = false;
  int _restSecondsLeft = 0;
  bool _paused = false;

  int get _restDuration {
    final parts = widget.exercise.restTime.split(' ');
    return int.tryParse(parts.first) ?? 60;
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_paused) return;
      setState(() {
        if (_resting) {
          if (_restSecondsLeft > 0) {
            _restSecondsLeft--;
          } else {
            _resting = false;
          }
        } else {
          _elapsedSeconds++;
        }
      });
    });
  }

  String _formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _completeSet() {
    if (_currentSet >= widget.exercise.sets) {
      _finish();
      return;
    }
    setState(() {
      _currentSet++;
      _resting = true;
      _restSecondsLeft = _restDuration;
    });
  }

  void _finish() {
    _timer?.cancel();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const CustomText('Workout Complete 🎉', variant: CustomTextVariant.h3),
        content: CustomText(
          'Great job finishing ${widget.exercise.name}. Keep the streak going!',
          variant: CustomTextVariant.bodyMuted,
        ),
        actions: [
          CustomButton(
            label: 'Done',
            fullWidth: false,
            onPressed: () {
              Navigator.pop(context);
              Navigator.popUntil(context, (r) => r.isFirst);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ex = widget.exercise;
    final color = AppColors.categoryColor(ex.category);

    return Scaffold(
      appBar: AppBar(
        title: CustomText(ex.name, variant: CustomTextVariant.h2),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.35), color.withOpacity(0.08)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(Icons.fitness_center, color: color, size: 72),
              ),
              const SizedBox(height: 24),
              if (_resting) _restView() else _activeView(color),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      label: _paused ? 'Resume' : 'Pause',
                      variant: CustomButtonVariant.outline,
                      icon: _paused ? Icons.play_arrow : Icons.pause,
                      onPressed: () => setState(() => _paused = !_paused),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      label: _resting
                          ? 'Skip Rest'
                          : (_currentSet >= ex.sets ? 'Finish' : 'Next Set'),
                      icon: _resting ? Icons.skip_next : Icons.check,
                      onPressed: _resting
                          ? () => setState(() {
                                _resting = false;
                              })
                          : _completeSet,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _activeView(Color color) {
    final ex = widget.exercise;
    return Column(
      children: [
        CustomText(_formatTime(_elapsedSeconds), variant: CustomTextVariant.stat),
        const SizedBox(height: 4),
        const CustomText('ELAPSED TIME', variant: CustomTextVariant.caption),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _statBlock('Set', '$_currentSet / ${ex.sets}', color),
            ),
            const SizedBox(width: 12),
            Expanded(child: _statBlock('Reps', ex.reps, color)),
          ],
        ),
      ],
    );
  }

  Widget _restView() {
    return Column(
      children: [
        const CustomText('RESTING', variant: CustomTextVariant.label, color: AppColors.secondary),
        const SizedBox(height: 8),
        CustomText(_formatTime(_restSecondsLeft), variant: CustomTextVariant.stat, color: AppColors.secondary),
        const SizedBox(height: 8),
        CustomText('Next: Set $_currentSet of ${widget.exercise.sets}',
            variant: CustomTextVariant.bodyMuted),
      ],
    );
  }

  Widget _statBlock(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CustomText(value, variant: CustomTextVariant.h2, color: color),
          CustomText(label, variant: CustomTextVariant.caption),
        ],
      ),
    );
  }
}
