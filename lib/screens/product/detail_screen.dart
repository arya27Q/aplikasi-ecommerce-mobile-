import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/shoe.dart';

class DetailScreen extends StatelessWidget {
  final Shoe shoe;

  const DetailScreen({super.key, required this.shoe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shoe.name),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product: ${shoe.name}', style: const TextStyle(fontSize: 24)),
            Text('Price: \$${shoe.price}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.favorite),
              label: const Text('Favorite this shoe & Go Back'),
              onPressed: () {
                context.pop('favorited');
              },
            )
          ],
        ),
      ),
    );
  }
}
