import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  bool toggleMealFavourite(Meal meal) {
    final shouldAddMeal = !state.contains(meal);
    if (shouldAddMeal) {
      state = [...state, meal];
      return true;
    } else {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    }
  }
}

final favouritesProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>(
  (ref) {
    return FavouriteMealsNotifier();
  },
);
