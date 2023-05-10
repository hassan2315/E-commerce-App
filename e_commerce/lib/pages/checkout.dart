import 'package:e_commerce/pages/payment.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';
import '../shared/appbar.dart';
import '../shared/colors.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Carttt = Provider.of<Cart>(context);
    final List items = Carttt.selectP;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarBlue,
        title: const Text("checkout screen"),
        actions: const [ProductsAndPrice()],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
                height: 550,
                child: items.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'Assets/animations/137836-add-to-cart.json',
                              height: 300,
                              width: 500,
                            ),
                            const Text(
                              'No Items Yet',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: Carttt.selectedProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          final product = Carttt.selectedProducts[index];

                          return GestureDetector(
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                title: Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                    "${product.price} - ${product.location}"),
                                leading: CircleAvatar(
                                  radius: 28,
                                  backgroundImage: AssetImage(product.imgPath),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Carttt.decrementQuantity(product);
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    Text(
                                      '${product.quantity}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Carttt.incrementQuantity(product);
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Carttt.delete(product);
                                      },
                                      icon: const Icon(Icons.delete_outlined),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentScreen()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(BTNblue),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 35)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
                  elevation: MaterialStateProperty.all(
                      4), // add elevation for a 3D effect
                  shadowColor: MaterialStateProperty.all(
                      BTNblue.withOpacity(0.4)), // add shadow color
                  overlayColor: MaterialStateProperty.all(BTNblue.withOpacity(
                      0.2)), // add overlay color on button press
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Pay \$${Carttt.price}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.payment),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
