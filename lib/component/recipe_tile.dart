import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecipeTile extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeTile({
    required this.recipe,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1
          ),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: switch (recipe["thumbnail"]!= null) {
                  true => CachedNetworkImage(
                    imageUrl: recipe['thumbnail'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  false => Placeholder(
                    color: Colors.grey,
                    fallbackHeight: 100,
                    fallbackWidth: 100
                  )
                }
              )
            ),
            Expanded(
              child: Text(
                recipe['name'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}