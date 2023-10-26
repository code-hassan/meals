

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/providers/favorites_provider.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

import '../providers/filter_provider.dart';
const kInitialFilters = {
  Filter.gultenFree : false,
  Filter.lactoseFree : false,
  Filter.vegetarianFree : false,
  Filter.veganFree : false,
};
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  // final List<Meal> _favoriteMeals = [];
  // Map<Filter,bool> _selectedFilters = kInitialFilters;
  // void _showInfoMessage(String message){
  //    ScaffoldMessenger.of(context).clearSnackBars();
  //    ScaffoldMessenger.of(context).showSnackBar(
  //      SnackBar(
  //          content: Text(message),
  //      ),
  //    );
  // }
  // void _toggleMealFavoriteStatus(Meal meal){
  //   final isExisting = _favoriteMeals.contains(meal);
  //
  //   if(isExisting){
  //    setState(() {
  //      _favoriteMeals.remove(meal);
  //    });
  //    _showInfoMessage("Meal is no longer a favorite");
  //   }else{
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage("Marked as a favorite!");
  //     });
  //   }
  //
  // }



  void _selectedPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }


   void _setScreen(String identifier)async{
     Navigator.of(context).pop();
    if(identifier == 'filters'){
     // final result =
      await Navigator.of(context).push<Map<Filter,bool>>(
          MaterialPageRoute(
              builder: (ctx)=>
           const FiltersScreen(
           //  currentFilters: _selectedFilters,
           ),
          ),
      );
     // setState(() {
     //   _selectedFilters = result ?? kInitialFilters;
     // });
    }

   }


  @override
  Widget build(BuildContext context) {
    final availabeMeals = ref.watch(filterMealsProvider);
    Widget activePage = CategoriesScreen(
     // onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availabeMeals,
    );
    var activePageTitle = "Categories";
    if(_selectedPageIndex == 1){
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      //  onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectedScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal),label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star),label: "Favorites"),
        ],
      ),
    );
  }
}
