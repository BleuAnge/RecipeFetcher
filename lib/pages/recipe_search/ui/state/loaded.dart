import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_fetcher/component/recipe_tile.dart';
import 'package:recipe_fetcher/pages/recipe_search/logic/cubit.dart';
import 'package:recipe_fetcher/utilities/enum.dart';

class RecipeSearchLoadedPage extends StatelessWidget {
  final SearchType searchType;
  final List<String> categories;
  final List<String> areas;
  final List<String> ingredients;
  final String selectedCategory;
  final String selectedArea;
  final String selectedIngredient;
  final List<Map<String, Map<String, dynamic>>> recipes;

  const RecipeSearchLoadedPage({
    required this.searchType,
    required this.categories,
    required this.areas,
    required this.ingredients,
    required this.selectedCategory,
    required this.selectedArea,
    required this.selectedIngredient,
    required this.recipes,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: Text("Recipe Search"),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.sizeOf(context).width, 64), 
            child: Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton<SearchType>(
                    value: searchType,
                    onChanged: (value) {
                      context.read<RecipeSearchCubit>().changeSearchType(value!);
                    },
                    items: SearchType.values.map(
                      (item) {
                        return DropdownMenuItem(
                          value: item, 
                          child: Text(
                            item.name
                          )
                        );
                      }
                    ).toList(),
                  ),
                  DropdownButton<String>(
                    value: switch (searchType) {
                      SearchType.CATEGORIES => selectedCategory,
                      SearchType.AREAS => selectedArea,
                      SearchType.INGREDIENTS => selectedIngredient
                    },
                    onChanged: (value) {
                      context.read<RecipeSearchCubit>().changeFilter(
                        context,
                        category: searchType == SearchType.CATEGORIES ? value : null,
                        area: searchType == SearchType.AREAS ? value : null,
                        ingredient: searchType == SearchType.INGREDIENTS ? value : null,
                      );
                    },
                    items: switch (searchType) {
                      SearchType.CATEGORIES => categories,
                      SearchType.AREAS => areas,
                      SearchType.INGREDIENTS => ingredients
                    }.map(
                      (item) {
                        return DropdownMenuItem(
                          value: item, 
                          child: Text(
                            item
                          )
                        );
                      }
                    ).toList(), 
                  )
                ],
              ),
            )
          ),
        ),
        body: CustomScrollView(
          slivers: [
            if (recipes.isEmpty)
              SliverList(
                delegate: SliverChildListDelegate([
                  Text(
                    "No Recipe"
                  ),
                ])
              ),
            if (recipes.isNotEmpty)
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: recipes.length,
                  (context, index) {
                    final recipe = recipes[index];
                    return GestureDetector(
                      onTap: () {
                        context.read<RecipeSearchCubit>().showRecipe(context, id: recipe.keys.first);
                      },
                      child: RecipeTile(
                        recipe: recipe.values.first
                      ),
                    );
                  }
                )
              )
          ],
        ),
      ),
    );
  }
}  