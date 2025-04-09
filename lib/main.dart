// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_fetcher/pages/recipe_search/logic/controller.dart';
import 'package:recipe_fetcher/pages/recipe_search/logic/cubit.dart';
import 'package:recipe_fetcher/utilities/recipe_repo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );
  
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider<RecipeRepository>(
        create: (context) => RecipeRepository(),
        child: BlocProvider<RecipeSearchCubit>(
          create: (context) => RecipeSearchCubit(),
          child: RecipeSearchController()
        ),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   RecipeModel? recipe;

//   Future<void> getRecipe() async {
//     final RecipeModel _recipe = await context.read<RecipeRepository>().getRandomRecipe();

//     setState(() {
//       recipe = _recipe;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(
//           vertical: 8.0
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             if (recipe != null)
//               CachedNetworkImage(
//                 imageUrl: recipe!.thumbnail,
//                 height: 300,
//                 width: 400,
//               ),
//             GestureDetector(
//               onTap: () {
//                 if (recipe != null) {
//                   Navigator.push(
//                     context, 
//                     MaterialPageRoute(
//                       builder: (_) {
//                         print(recipe!.ingredients);
//                         return RecipeView(recipe: recipe!);
//                       }
//                     )
//                   );
//                 }
//               },
//               child: Text(
//                 recipe?.name ?? "No Recipe",
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: getRecipe,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
