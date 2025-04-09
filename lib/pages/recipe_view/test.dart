import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_fetcher/utilities/recipe_model.dart';

class RecipeView extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeView({
    required this.recipe,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(recipe.name),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedNetworkImage(
                      imageUrl: recipe.thumbnail, 
                      height: 300, 
                      width: 400
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Category: ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              )
                            ),
                            GestureDetector(
                              onTap: () {
                                
                              },
                              child: Text(
                                recipe.category,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue
                                ),
                              ),
                            )
                          ]
                        ),
                        Row(
                          children: [
                            Text(
                              "Area: ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              )
                            ),
                            GestureDetector(
                              onTap: () {
                                
                              },
                              child: Text(
                                recipe.area,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue
                                ),
                              ),
                            )
                          ]
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    if (recipe.tags.isNotEmpty)
                      ...[
                        Text(
                          "Tags",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Wrap(
                          spacing: 4,
                          children: recipe.tags.map(
                            (tag) {
                              return GestureDetector(
                                onTap: () {

                                },
                                child: Text(
                                  tag,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.blue
                                  ),
                                ),
                              );
                            }
                          ).toList(),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    Text(
                      "Ingredients: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    ListView.builder(
                      physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
                      shrinkWrap: true,
                      itemCount: recipe.ingredients.length,
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> ingredient = recipe.ingredients[index];
                        return Text("${ingredient.keys.first}: ${ingredient.values.first}");
                      }
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Text(
                      "Instructions: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(recipe.instructions),
                  ],
                ),
              ),
            ])
          )
        ] 
      ),
    );
  }
}