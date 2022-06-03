import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:style/provider/cart_provider.dart';

import 'package:intl/intl.dart';

class MyProductView extends StatefulWidget {
  @override
  State<MyProductView> createState() => _MyProductViewState();
}

class _MyProductViewState extends State<MyProductView> {
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
                  'Менің тапсырыстарым',
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: cartProvider.getCartList.length,
                  itemBuilder: (context, index) {
                    var data = cartProvider.cartList[index];

                    return Product(
                      image: data.image,
                      text: data.text,
                      price: data.price,
                      count: data.count,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Product extends StatelessWidget {
  final String image;
  final String text;
  final int price;
  final int count;

  const Product({Key key, this.image, this.text, this.price, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 70,
                width: 70,
                child: Image(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Container(
                  height: 70,
                  // color: Colors.amber,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              count.toString() + ' дана',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20),
              Text(
                price.toString() + ' ₸',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
