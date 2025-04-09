import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_fetcher/pages/recipe_search/logic/cubit.dart';
import 'package:recipe_fetcher/pages/recipe_search/ui/state/loaded.dart';

class RecipeSearchController extends StatefulWidget {
  const RecipeSearchController({super.key});

  @override
  State<RecipeSearchController> createState() => _RecipeSearchControllerState();
}

class _RecipeSearchControllerState extends State<RecipeSearchController> {
  @override
  void initState() {
    context.read<RecipeSearchCubit>().fetchFilters(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipeSearchCubit, RecipeSearchState>(
      builder: (context, state) {
        return switch (state) {
          RecipeSearchInitialState() => Container(),

          RecipeSearchLoadingState() => const Center(
            child: CircularProgressIndicator(),
          ),

          RecipeSearchLoadedState(
            :var searchType,
            :var categories,
            :var areas,
            :var ingredients,
            :var selectedCategory,
            :var selectedArea,
            :var selectedIngredient,
            :var recipes
          ) => RecipeSearchLoadedPage(
            searchType: searchType,
            categories: categories,
            areas: areas,
            ingredients: ingredients,
            selectedCategory: selectedCategory,
            selectedArea: selectedArea,
            selectedIngredient: selectedIngredient,
            recipes: recipes
          ),
        };
      }
    ); 
  }
}