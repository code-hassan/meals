import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

import '../screens/filters.dart';

enum Filter{
  gultenFree,
  lactoseFree,
  vegetarianFree,
  veganFree,
}

class FilterNotifier extends StateNotifier<Map<Filter,bool>>{
  FilterNotifier() : super({
    Filter.gultenFree : false,
    Filter.lactoseFree : false,
    Filter.vegetarianFree : false,
    Filter.veganFree : false,
  });

  void setFilters(Map<Filter,bool> chooseFilters){
    state = chooseFilters;
  }

  void setFilter(Filter filter , bool isActive){
    state = {
      ...state,
      filter :  isActive,
    };
  }

}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter,bool>> ((ref) {
  return FilterNotifier();
});

final filterMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);
  return meals.where((meal) {
    if(activeFilters[Filter.gultenFree]! && !meal.isGlutenFree){
      return false;
    }

    if(activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
      return false;
    }

    if(activeFilters[Filter.vegetarianFree]! && !meal.isVegetarian){
      return false;
    }

    if(activeFilters[Filter.veganFree]! && !meal.isVegan){
      return false;
    }
    return true;
  }).toList();
});

