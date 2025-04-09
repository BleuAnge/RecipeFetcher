// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_fetcher/component/recipe_tile.dart';
import 'package:recipe_fetcher/pages/recipe_view/main.dart';
import 'package:recipe_fetcher/utilities/recipe_model.dart';
import 'package:recipe_fetcher/utilities/recipe_repo.dart';

class SimilarRecipeModal extends StatelessWidget {
  final List<Map<String, Map<String, dynamic>>> recipes;

  const SimilarRecipeModal({
    required this.recipes,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Similar Recipes"),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height * .45,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1
          ),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: recipes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                final RecipeModel recipe = await context.read<RecipeRepository>().getRecipe(
                  id: recipes[index].keys.first
                );
      
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
              },
              child: RecipeTile(recipe: recipes[index].values.first)
            );
          },
        ),
      ),
    );
  }
}