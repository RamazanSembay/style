import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:style/provider/cart_provider.dart';
import 'package:style/view/cart_view.dart';
import 'package:style/view/home_view.dart';
import 'package:style/widget/nav_bar.dart';

import 'package:intl/intl.dart';

class SuccessView extends StatefulWidget {
  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
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
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Color(0xffFFDB53),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('images/success.png'),
                    height: 150,
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Сәттілік',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 350,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      '${formatter.format(totalPrice.toInt()) + ' ₸'}'
                          .replaceAll(',', ' '),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Төленді',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                InkWell(
                  onTap: () {
                    // on home
                    Get.to(NavBar());
                  },
                  child: Container(
                    height: 60,
                    width: 320,
                    decoration: BoxDecoration(
                      color: Color(0xffFFDB53),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Center(
                      child: Text(
                        'Басты бетке өту'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
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
