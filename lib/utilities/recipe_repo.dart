import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:recipe_fetcher/utilities/enum.dart';
import 'package:recipe_fetcher/utilities/recipe_model.dart';

class RecipeRepository {
  static const String api = "http://www.themealdb.com/api/json/v1/1";

  Future<RecipeModel> getRandomRecipe() async {
    final String route = "$api/random.php";

    final response = await http.get(Uri.parse(route));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      final List first = decoded.entries.first.value;

      final Map<String, dynamic> recipe = first[0];
      
      return RecipeModel.fromMap(recipe);
    }

    throw Exception('Failed to load recipe');
  }

  Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse("$api/list.php?c=list"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      return <String>[
        ...decoded.entries.first.value.map((e) => e["strCategory"])
      ];
    }

    throw Exception('Failed to load categories');
  }

  Future<List<String>> getAreas() async {
    final response = await http.get(Uri.parse("$api/list.php?a=list"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      return <String>[
        ...decoded.entries.first.value.map((e) => e["strArea"])
      ];
    }

    throw Exception('Failed to load areas');
  }

  Future<List<String>> getIngredients() async {
    final response = await http.get(Uri.parse("$api/list.php?i=list"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      return <String>[
        ...decoded.entries.first.value.map((e) => e["strIngredient"])
      ];
    }

    throw Exception('Failed to load ingredients');
  }

  Future<List<Map<String, Map<String, dynamic>>>> getSearch({
    required SearchType type,
    required String value
  }) async {
    final String route = switch (type) {
      SearchType.CATEGORIES => "/filter.php?c=$value",
      SearchType.AREAS => "/filter.php?a=$value",
      SearchType.INGREDIENTS => "/filter.php?i=$value"
    };

    final response = await http.get(Uri.parse("$api$route"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      return <Map<String, Map<String, dynamic>>>[
        ...decoded.entries.first.value.map((e) => {
          e["idMeal"] as String : {
            "name" : e["strMeal"],
            "thumbnail" : e["strMealThumb"]
          }
        })
      ];
    }

    throw Exception('Failed to load recipes');
  }

  Future<RecipeModel> getRecipe({
    required String id
  }) async {
    final String route = "$api/lookup.php?i=$id";

    final response = await http.get(Uri.parse(route));

    if (response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);

      final List first = decoded.entries.first.value;

      final Map<String, dynamic> recipe = first[0];
      
      return RecipeModel.fromMap(recipe);
    }

    throw Exception('Failed to load recipe');
  }
}