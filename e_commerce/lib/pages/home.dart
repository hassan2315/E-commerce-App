import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:e_commerce/pages/checkout.dart';

import 'package:e_commerce/pages/profile_page.dart';
import 'package:e_commerce/provider/favourite1.dart';
import 'package:e_commerce/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/item.dart';
import '../provider/cart.dart';
import '../shared/appbar.dart';
import 'detalis_screen.dart';
import 'favourite.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CheckOut()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FavouriteScreen(
              onDelete: (Item item) {
                setState(() {
                  item.isFavorite = false;
                });
                Provider.of<FavouritesProvider>(context, listen: false)
                    .removeFromFavourites(item);
              },
            ),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Carttt = Provider.of<Cart>(context);
    return Scaffold(
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      items[index].imgPath,
                      fit: BoxFit.cover,
                      height: 100,
                      width: 150,
                    ),
                  ),
                  title: Text(
                    items[index].name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    "\$${items[index].price}",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        color: Colors.green,
                        onPressed: () {
                          Carttt.add(items[index]);
                        },
                        icon: const Icon(Icons.add),
                      ),
                      IconButton(
                        color:
                            items[index].isFavorite ? Colors.red : Colors.grey,
                        onPressed: () {
                          setState(() {
                            items[index].isFavorite = !items[index].isFavorite;
                          });
                          final favouritesProvider =
                              Provider.of<FavouritesProvider>(context,
                                  listen: false);
                          if (items[index].isFavorite) {
                            favouritesProvider.addToFavourites(items[index]);
                          } else {
                            favouritesProvider
                                .removeFromFavourites(items[index]);
                          }
                        },
                        icon: Icon(
                          items[index].isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Details(product: items[index]),
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: BTNblue,
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.white,
          color: BTNblue,
          buttonBackgroundColor: BTNblue,
          height: 60,
          items: const <Widget>[
            Icon(Icons.home_outlined, size: 30, color: Colors.white),
            Icon(Icons.add_shopping_cart_outlined,
                size: 30, color: Colors.white),
            Icon(Icons.account_circle_outlined, size: 30, color: Colors.white),
            Icon(Icons.favorite_border_outlined, size: 30, color: Colors.white),
          ],
          index: _selectedIndex,
          onTap: _onItemTapped,
        ),
        appBar: AppBar(
          centerTitle: true,
          actions: const [
            ProductsAndPrice(),
          ],
          backgroundColor: appbarBlue,
          title: const Text("Home"),
        ));
  }
}
