import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/provider/cart_provider.dart';

import 'package:intl/intl.dart';

class MySuccessView extends StatefulWidget {
  @override
  State<MySuccessView> createState() => _MySuccessViewState();
}

class _MySuccessViewState extends State<MySuccessView> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    int totalPrice = cartProvider.subTotal();
    int quantity = cartProvider.subTotal1();

    if (cartProvider.getCartList.isEmpty) {
      setState(() {
        totalPrice = 0;
      });
    }

    var formatter = NumberFormat('#,###');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              height: 50,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      // on back
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'images/back_a.png',
                      height: 34,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Text(
                  'Менің төлемдерім',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
