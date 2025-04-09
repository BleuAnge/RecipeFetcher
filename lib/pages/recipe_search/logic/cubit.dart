// ignore_for_file: use_build_context_synchronously

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_fetcher/pages/recipe_view/main.dart';
import 'package:recipe_fetcher/utilities/enum.dart';
import 'package:recipe_fetcher/utilities/recipe_model.dart';
import 'package:recipe_fetcher/utilities/recipe_repo.dart';

part 'state.dart';

class RecipeSearchCubit extends Cubit<RecipeSearchState> {
  RecipeSearchCubit() : super(RecipeSearchInitialState());

  void fetchFilters(BuildContext context) async {
    emit(RecipeSearchLoadingState());

    final result = await Future.wait([
      context.read<RecipeRepository>().getCategories(),
      context.read<RecipeRepository>().getAreas(),
      context.read<RecipeRepository>().getIngredients(),
      context.read<RecipeRepository>().getSearch(
        type: SearchType.CATEGORIES, 
        value: "beef"
      )
    ]);

    emit(
      RecipeSearchLoadedState(
        categories: result[0] as List<String>,
        areas: result[1] as List<String>, 
        ingredients: result[2] as List<String>,
        selectedCategory: result[0][0] as String,
        selectedArea: result[1][0] as String,
        selectedIngredient: result[2][0] as String,
        recipes: result[3] as List<Map<String, Map<String, dynamic>>>
      )
    );
  }

  void changeSearchType(SearchType searchType) {
    final currentState = state as RecipeSearchLoadedState;
    
    emit(
      currentState.copyWith(
        searchType: searchType
      )
    );
  }

  void changeFilter(BuildContext context,{
    String? category,
    String? area,
    String? ingredient
  }) async {
    final currentState = state as RecipeSearchLoadedState;

    final List<Map<String, Map<String, dynamic>>> recipes = await context.read<RecipeRepository>().getSearch(
      type: currentState.searchType, 
      value: category ?? area ?? ingredient ?? ""
    );

    emit(
      currentState.copyWith(
        selectedCategory: category,
        selectedArea: area,
        selectedIngredient: ingredient,
        recipes: recipes
      )
    );
  }

  void getRandomRecipe(BuildContext context) async {
    final RecipeModel recipe = await context.read<RecipeRepository>().getRandomRecipe();

    Future.delayed(
      Duration.zero,
      () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => RecipeView(
              recipe: recipe,
            )
          )
        );
      }
    );
  }

  void showRecipe(BuildContext context, {required String id}) async {
    final RecipeModel recipe = await context.read<RecipeRepository>().getRecipe(id: id);

    Future.delayed(
      Duration.zero,
      () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => RecipeView(
              recipe: recipe,
            )
          )
        );
      }
    );
  }
}