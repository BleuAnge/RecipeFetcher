part of 'cubit.dart';

sealed class RecipeSearchState extends Equatable {
  const RecipeSearchState();

  @override
  List<Object> get props => [];
}

final class RecipeSearchInitialState extends RecipeSearchState {}

final class RecipeSearchLoadingState extends RecipeSearchState {}

final class RecipeSearchLoadedState extends RecipeSearchState {
  final SearchType searchType;
  final List<String> categories;
  final List<String> areas;
  final List<String> ingredients;
  final String selectedCategory;
  final String selectedArea;
  final String selectedIngredient;
  final List<Map<String, Map<String, dynamic>>> recipes;

  const RecipeSearchLoadedState({
    this.searchType = SearchType.CATEGORIES,
    required this.categories, 
    required this.areas, 
    required this.ingredients, 
    required this.selectedCategory, 
    required this.selectedArea, 
    required this.selectedIngredient, 
    this.recipes = const []
  });

  @override
  List<Object> get props => [
    searchType,
    selectedCategory, 
    selectedArea, 
    selectedIngredient, 
    recipes
  ];

  RecipeSearchLoadedState copyWith({
    SearchType? searchType,
    String? selectedCategory, 
    String? selectedArea, 
    String? selectedIngredient, 
    List<Map<String, Map<String, dynamic>>>? recipes
  }) => RecipeSearchLoadedState(
    searchType: searchType ?? this.searchType,
    categories: categories, 
    areas: areas, 
    ingredients: ingredients, 
    selectedCategory: selectedCategory ?? this.selectedCategory, 
    selectedArea: selectedArea ?? this.selectedArea, 
    selectedIngredient: selectedIngredient ?? this.selectedIngredient, 
    recipes: recipes ?? this.recipes
  );

}