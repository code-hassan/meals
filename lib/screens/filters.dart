import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../providers/filter_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  //  required this.currentFilters,
  });
 //  final Map<Filter,bool> currentFilters;
//   @override
//   ConsumerState<FiltersScreen> createState() => _FiltersScreenState();
// }
//
// class _FiltersScreenState extends ConsumerState<FiltersScreen> {
//   var _glutenFreeFilterSet = false;
//   var _lactoseFreeFilterSet = false;
//   var _vegetarianFreeFilterSet = false;
//   var _veganFreeFilterSet = false;
//   @override
//   void initState() {
//     super.initState();
//     final activeFilter = ref.read(filterProvider);
//     _glutenFreeFilterSet = activeFilter[Filter.gultenFree]!;
//     _lactoseFreeFilterSet = activeFilter[Filter.lactoseFree]!;
//     _vegetarianFreeFilterSet = activeFilter[Filter.vegetarianFree]!;
//     _veganFreeFilterSet = activeFilter[Filter.veganFree]!;
//   }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final activeFilters = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      // drawer: MainDrawer(
      //   onSelectedScreen: (identifier){
      //     Navigator.of(context).pop();
      //     if(identifier == 'meals'){
      //       Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => TabsScreen()));
      //     }
      //   },
      // ),
      body:  Column(
          children: [
            SwitchListTileFilter(
              value: activeFilters[Filter.gultenFree]!,
              onChanged: (isChecked){
                // setState(() {
                //   _glutenFreeFilterSet = isChecked;
                // });
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.gultenFree, isChecked);
              },
              title: "Gluten-free",
              subTitle: "Only include gluten-free meals",
            ),
            SwitchListTileFilter(
                value: activeFilters[Filter.lactoseFree]!,
                onChanged: (isChecked){
                  ref
                      .read(filterProvider.notifier)
                      .setFilter(Filter.lactoseFree, isChecked);
                },
                title: "Lactose-free",
                subTitle: "Only include lactose-free meals",
            ),
            SwitchListTileFilter(
              value: activeFilters[Filter.vegetarianFree]!,
              onChanged: (isChecked){
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.vegetarianFree, isChecked);
              },
              title: "Vegetarian",
              subTitle: "Only include vegetarian meals",
            ),
            SwitchListTileFilter(
              value: activeFilters[Filter.veganFree]!,
              onChanged: (isChecked){
                ref
                    .read(filterProvider.notifier)
                    .setFilter(Filter.veganFree, isChecked);
              },
              title: "Vegan",
              subTitle: "Only include Vegan meals",
            ),
            // SwitchListTile(
            //     value: activeFilters[Filter.gultenFree]!,
            //     onChanged: (isChecked){
            //       // setState(() {
            //       //   _glutenFreeFilterSet = isChecked;
            //       // });
            //       ref
            //           .read(filterProvider.notifier)
            //           .setFilter(Filter.gultenFree, isChecked);
            //     },
            //   title: Text(
            //     "Gluten-free",
            //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
            //       color: Theme.of(context).colorScheme.onBackground,
            //     ),
            //   ),
            //  subtitle: Text(
            //    "Only include gluten-free meals",
            //    style: Theme.of(context).textTheme.labelMedium!.copyWith(
            //      color: Theme.of(context).colorScheme.onBackground,
            //    ),
            //  ),
            //   activeColor: Theme.of(context).colorScheme.tertiary,
            //   contentPadding: const EdgeInsets.only(left: 34,right: 22),
            // ),
            // SwitchListTile(
            //   value: _lactoseFreeFilterSet,
            //   onChanged: (isChecked){
            //     setState(() {
            //       _lactoseFreeFilterSet = isChecked;
            //     });
            //   },
            //   title: Text(
            //     "Lactose-free",
            //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
            //       color: Theme.of(context).colorScheme.onBackground,
            //     ),
            //   ),
            //   subtitle: Text(
            //     "Only include lactose-free meals",
            //     style: Theme.of(context).textTheme.labelMedium!.copyWith(
            //       color: Theme.of(context).colorScheme.onBackground,
            //     ),
            //   ),
            //   activeColor: Theme.of(context).colorScheme.tertiary,
            //   contentPadding: const EdgeInsets.only(left: 34,right: 22),
            // ),
            // SwitchListTile(
            //   value: _vegetarianFreeFilterSet,
            //   onChanged: (isChecked){
            //     setState(() {
            //       _vegetarianFreeFilterSet = isChecked;
            //     });
            //   },
            //   title: Text(
            //     "Vegetarian",
            //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
            //       color: Theme.of(context).colorScheme.onBackground,
            //     ),
            //   ),
            //   subtitle: Text(
            //     "Only include vegetarian meals",
            //     style: Theme.of(context).textTheme.labelMedium!.copyWith(
            //       color: Theme.of(context).colorScheme.onBackground,
            //     ),
            //   ),
            //   activeColor: Theme.of(context).colorScheme.tertiary,
            //   contentPadding: const EdgeInsets.only(left: 34,right: 22),
            // ),
            // SwitchListTile(
            //   value: _veganFreeFilterSet,
            //   onChanged: (isChecked){
            //     setState(() {
            //       _veganFreeFilterSet = isChecked;
            //     });
            //   },
            //   title: Text(
            //     "Vegan",
            //     style: Theme.of(context).textTheme.titleLarge!.copyWith(
            //       color: Theme.of(context).colorScheme.onBackground,
            //     ),
            //   ),
            //   subtitle: Text(
            //     "Only include vegan meals",
            //     style: Theme.of(context).textTheme.labelMedium!.copyWith(
            //       color: Theme.of(context).colorScheme.onBackground,
            //     ),
            //   ),
            //   activeColor: Theme.of(context).colorScheme.tertiary,
            //   contentPadding: const EdgeInsets.only(left: 34,right: 22),
            // ),
          ],),
    );
  }
}

class SwitchListTileFilter extends StatelessWidget {
  const SwitchListTileFilter({super.key, required this.value, this.onChanged, required this.title, required this.subTitle});
   final bool value;
   final void Function(bool)? onChanged;
   final String title;
   final String subTitle;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34,right: 22),
    );
  }
}
