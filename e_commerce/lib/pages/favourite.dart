import 'package:e_commerce/model/item.dart';
import 'package:e_commerce/provider/favourite1.dart';
import 'package:e_commerce/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'detalis_screen.dart';

class FavouriteScreen extends StatelessWidget {
  final Function(Item) onDelete;
  const FavouriteScreen({required this.onDelete, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavouritesProvider>(context);
    final List<Item> items = favProvider.favourites;

    void _handleDelete(Item item) {
      favProvider.removeFromFavourites(item);
      onDelete(item);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarBlue,
        title: const Text('Favourites'),
        centerTitle: true,
      ),
      body: items.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'Assets/animations/70332-no-data-animation.json', // replace with your animation file
                  height: 400,
                  width: 500,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No Favourite Items Yet',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Details(product: items[index]),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(
                            color: BTNblue,
                            width: 2.0,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  items[index].imgPath,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[index].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${items[index].price}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          _handleDelete(items[index]);
                        },
                        child: Icon(
                          Icons.favorite,
                          color: items[index].isFavorite
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
