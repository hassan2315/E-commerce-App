import 'package:e_commerce/pages/favourite.dart';
import 'package:e_commerce/provider/cart.dart';
import 'package:e_commerce/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/item.dart';
import '../provider/favourite1.dart';
import '../shared/appbar.dart';
import 'checkout.dart';

class Details extends StatefulWidget {
  final Item product;

  const Details({Key? key, required this.product}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Item _selectedItem;
  bool isShowMore = true;
  @override
  void initState() {
    super.initState();
    _selectedItem = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavouritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: const [
          ProductsAndPrice(),
        ],
        backgroundColor: appbarBlue,
        title: const Text("Details screen"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(widget.product.imgPath),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300.withOpacity(0.4),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "\$ ${widget.product.price}",
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 129, 129),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            "New",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          width: 1,
                        ),
                        Row(
                          children: List.generate(
                            5,
                            (index) => const Icon(
                              Icons.star,
                              size: 26,
                              color: Color.fromARGB(255, 255, 191, 0),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 66,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.edit_location,
                              size: 26,
                              color: Color.fromARGB(168, 17, 50, 237),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              widget.product.location,
                              style: const TextStyle(fontSize: 19),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Details : ",
                        style: TextStyle(fontSize: 22),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Introducing our new online shop app! With our app, you can browse and purchase a wide variety of products from the comfort of your own home. Our user-friendly interface makes it easy to search for products by category, brand, or keyword, and our secure checkout process ensures that your information is always safe.",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                      maxLines: isShowMore ? 3 : null,
                      overflow: TextOverflow.fade,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          isShowMore = !isShowMore;
                        });
                      },
                      child: Text(
                        isShowMore ? "Show more" : "Show less",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final favouritesProvider =
                                Provider.of<FavouritesProvider>(context,
                                    listen: false);
                            if (widget.product.isFavorite) {
                              favouritesProvider
                                  .removeFromFavourites(widget.product);
                            } else {
                              favouritesProvider
                                  .addToFavourites(widget.product);
                            }
                            setState(() {
                              widget.product.isFavorite =
                                  !widget.product.isFavorite;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FavouriteScreen(
                                          onDelete: (Item) {},
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: BTNblue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          child: const Text("Add to favourites"),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: IconButton(
                            onPressed: () {
                              final Carttt =
                                  Provider.of<Cart>(context, listen: false);
                              if (widget.product.isFavorite) {
                                Carttt.add(widget.product);
                              } else {
                                Carttt.add(widget.product);
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const CheckOut()));
                            },
                            icon: const Icon(Icons.shopping_cart),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
