import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/custom_textfield.dart';
import '../../../data/models/exercise_model.dart';
import '../../workouts/screens/exercise_detail_screen.dart';
import '../providers/favorites_providers.dart';
class FavoritesScreen extends ConsumerStatefulWidget {
  const FavoritesScreen({super.key});

  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref
        .watch(favoriteExercisesProvider)
        .where((e) => e.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const CustomText('Favorites', variant: CustomTextVariant.h2)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                hint: 'Search saved exercises',
                controller: _searchController,
                prefixIcon: Icons.search,
                onChanged: (v) => setState(() => _query = v),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: favorites.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 84,
                              height: 84,
                              decoration: BoxDecoration(
                                color: AppColors.danger.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.favorite_border,
                                  size: 34, color: AppColors.danger),
                            ),
                            const SizedBox(height: 16),
                            const CustomText('No saved exercises yet',
                                variant: CustomTextVariant.h3),
                            const SizedBox(height: 4),
                            const CustomText('Tap the heart on any exercise to save it here',
                                variant: CustomTextVariant.bodyMuted, align: TextAlign.center),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: favorites.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (_, i) => _favoriteTile(favorites[i]),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _favoriteTile(ExerciseModel ex) {
    final color = AppColors.categoryColor(ex.category);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
        boxShadow: AppShadows.card,
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.fitness_center, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ExerciseDetailScreen(exercise: ex))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(ex.name, variant: CustomTextVariant.h3),
                  CustomText(ex.category, variant: CustomTextVariant.caption),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () => ref.read(favoriteIdsProvider.notifier).toggle(ex.id),
            icon: const Icon(Icons.close, color: AppColors.textMuted, size: 20),
          ),
        ],
      ),
    );
  }
}
