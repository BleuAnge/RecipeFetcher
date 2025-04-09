import 'dart:convert';

class RecipeModel {
  final String id;
  final String name;
  final String alternativeName;
  final String category;
  final String area;
  final String instructions;
  final String thumbnail;
  final List<String> tags;
  final String youtubeLink;
  final List<Map<String, String>> ingredients;
  final String source;

  RecipeModel({
    required this.id,
    required this.name,
    required this.alternativeName,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnail,
    required this.tags,
    required this.youtubeLink,
    required this.ingredients,
    required this.source,
  });

  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    final List<String> tags = map["strTags"]?.split(",").toList() ?? [];

    final List<Map<String, String>> ingredients = [];
    
    for (var index in List.generate(20, (index) => ++index)) {
      if (map["strIngredient$index"] == null) break;
      if (map["strIngredient$index"].isEmpty) break;
      if (map["strIngredient$index"] == " ") break;

      ingredients.add({
        map["strIngredient$index"] : map["strMeasure$index"]
      });
    }

    return RecipeModel(
      id: map["idMeal"], 
      name: map["strMeal"], 
      alternativeName: map["strMealAlternate"] ?? "", 
      category: map["strCategory"] , 
      area: map["strArea"], 
      instructions: map["strInstructions"], 
      thumbnail: map["strMealThumb"], 
      tags: tags, 
      youtubeLink: map["strYoutube"], 
      ingredients: ingredients, 
      source: map["strSource"] ?? ""
    );
  }

  factory RecipeModel.fromJson(String json) {
    return RecipeModel.fromMap(jsonDecode(json));
  }

  Map<String, dynamic> get toMap {
    return {
      
    };
  }
}