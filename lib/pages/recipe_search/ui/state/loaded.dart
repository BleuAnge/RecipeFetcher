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
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text("Recipe Search"),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.sizeOf(context).width, 48), 
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black,
                    width: 1
                  ),
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1
                  )
                )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<SearchType>(
                      dropdownColor: Colors.white,
                      value: searchType,
                      onChanged: (value) {
                        context.read<RecipeSearchCubit>().changeSearchType(value!);
                      },
                      alignment: Alignment.bottomRight,
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
        floatingActionButton: GestureDetector(
          onTap: () {
            context.read<RecipeSearchCubit>().getRandomRecipe(context);
          },
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              border: Border.all(
                color: Colors.blue,
                width: 1
              ),
              borderRadius: BorderRadius.circular(50)
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.question_mark,
                color: Colors.white,
                size: 48,
              ),
            ),
          ),
        ),
      ),
    );
  }
}  