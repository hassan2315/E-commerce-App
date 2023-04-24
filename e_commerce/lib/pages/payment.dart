import 'package:e_commerce/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Screen'),
        backgroundColor: appbarBlue,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Align(
          alignment: Alignment.center,
          child: Lottie.asset(
            'Assets/animations/83666-payment-successfull.json',
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
