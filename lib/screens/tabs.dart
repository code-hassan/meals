

import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

import '../models/meal.dart';
const kInitialFilters = {
  Filter.gultenFree : false,
  Filter.lactoseFree : false,
  Filter.vegetarianFree : false,
  Filter.veganFree : false,
};
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter,bool> _selectedFilters = kInitialFilters;
  void _showInfoMessage(String message){
     ScaffoldMessenger.of(context).clearSnackBars();
     ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
           content: Text(message),
       ),
     );
  }
  void _toggleMealFavoriteStatus(Meal meal){
    final isExisting = _favoriteMeals.contains(meal);

    if(isExisting){
     setState(() {
       _favoriteMeals.remove(meal);
     });
     _showInfoMessage("Meal is no longer a favorite");
    }else{
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage("Marked as a favorite!");
      });
    }

  }



  void _selectedPage(int index){
    setState(() {
      _selectedPageIndex = index;
    });
  }


   void _setScreen(String identifier)async{
     Navigator.of(context).pop();
    if(identifier == 'filters'){
      final result = await Navigator.of(context).push<Map<Filter,bool>>(
          MaterialPageRoute(
              builder: (ctx)=>
           FiltersScreen(currentFilters: _selectedFilters,),
          ),
      );
     setState(() {
       _selectedFilters = result ?? kInitialFilters;
     });
    }
   }


  @override
  Widget build(BuildContext context) {

    final availabeMeals = dummyMeals.where((meal) {
      if(_selectedFilters[Filter.gultenFree]! && !meal.isGlutenFree){
        return false;
      }

      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }

      if(_selectedFilters[Filter.vegetarianFree]! && !meal.isVegetarian){
        return false;
      }

      if(_selectedFilters[Filter.veganFree]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();



    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availabeMeals,
    );
    var activePageTitle = "Categories";
    if(_selectedPageIndex == 1){
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
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
