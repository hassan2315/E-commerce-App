import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../model/item.dart';
import '../provider/favourite1.dart';
import '../shared/colors.dart';
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
                  'Assets/animations/129489-heart-filled.json',
                  height: 200,
                  width: 500,
                ),
                const SizedBox(height: 16),
                const Text(
                  'No Favourite Items Yet',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                return Card(
                  color: Colors.grey.shade200.withOpacity(0.9),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25))),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(product: item),
                        ),
                      );
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        item.imgPath,
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                    ),
                    title: Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          '\$${item.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          item.location,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        _handleDelete(item);
                      },
                      child: Icon(
                        Icons.favorite,
                        color: item.isFavorite ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                endIndent: 7,
                indent: 7,
                thickness: 2,
              ),
              itemCount: items.length,
            ),
    );
  }
}
