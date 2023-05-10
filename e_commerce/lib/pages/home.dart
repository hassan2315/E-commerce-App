import 'package:custom_navigation_bar/custom_navigation_bar.dart';
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
  final TextEditingController _searchController = TextEditingController();

  List<Item> _searchedItems = items;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
        break;
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Carttt = Provider.of<Cart>(context);

    return Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchedItems = items
                        .where((item) => item.name
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                },
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  hintText: 'Search...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(_searchedItems.length, (index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Details(product: _searchedItems[index]),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              _searchedItems[index].imgPath,
                              fit: BoxFit.cover,
                              height: 150,
                              width: double.infinity,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 1,
                            child: IconButton(
                              onPressed: () {
                                final favouritesProvider =
                                    Provider.of<FavouritesProvider>(context,
                                        listen: false);
                                if (_searchedItems[index].isFavorite) {
                                  favouritesProvider.removeFromFavourites(
                                      _searchedItems[index]);
                                } else {
                                  favouritesProvider
                                      .addToFavourites(_searchedItems[index]);
                                }
                                setState(() {
                                  _searchedItems[index].isFavorite =
                                      !_searchedItems[index].isFavorite;
                                });
                              },
                              icon: Icon(
                                _searchedItems[index].isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _searchedItems[index].isFavorite
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 177,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Center(
                                    child: Text(
                                      _searchedItems[index].name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Center(
                                    child: Text(
                                      "\$${_searchedItems[index].price}",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          height: 70,
          child: CustomNavigationBar(
            backgroundColor: BTNblue,
            isFloating: true,
            borderRadius: const Radius.circular(60),
            selectedColor: Colors.white,
            unSelectedColor: Colors.grey.shade300.withOpacity(0.9),
            strokeColor: Colors.transparent,
            scaleFactor: 0.3,
            iconSize: 27,
            items: [
              CustomNavigationBarItem(icon: const Icon(Icons.home_outlined)),
              CustomNavigationBarItem(icon: const Icon(Icons.shopping_bag)),
              CustomNavigationBarItem(icon: const Icon(Icons.person)),
              CustomNavigationBarItem(icon: const Icon(Icons.favorite_outline)),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
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
