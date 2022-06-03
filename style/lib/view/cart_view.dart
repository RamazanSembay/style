import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:style/view/transaction_view.dart';

import '../provider/cart_provider.dart';
import 'package:intl/intl.dart';

class CartView extends StatefulWidget {
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  int cart_quantity = 1;

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
      bottomNavigationBar: Nav(),
      body: Column(
        children: [
          SizedBox(height: 50),
          Text(
            'Себет',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: cartProvider.getCartList.isEmpty
                  ? Center(
                      child: Column(
                      children: [
                        SizedBox(height: 50),
                        SvgPicture.asset(
                          'images/empty.svg',
                          width: 130.0,
                          height: 130.0,
                        ),
                        SizedBox(height: 50),
                        Text(
                          'Себетке ешнарсе салған жоқсыз',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ))
                  : Container(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: cartProvider.getCartList.length,
                        itemBuilder: (context, index) {
                          var data = cartProvider.cartList[index];

                          void quantityFunction() {
                            FirebaseFirestore.instance
                                .collection('Себет')
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .collection('Себет')
                                .doc(data.id)
                                .update({
                              'Количество': cart_quantity,
                            });
                          }

                          return Product(
                            image: data.image,
                            text: data.text,
                            price: data.price,
                            count: data.count,
                            addCount: () {
                              // count

                              setState(() {
                                cart_quantity++;
                                quantityFunction();
                                print(data.id);
                              });
                            },
                            removeCount: () {
                              // remove

                              if (cart_quantity > 1) {
                                setState(() {
                                  cart_quantity--;
                                  quantityFunction();
                                });
                              }
                            },
                            onDelete: () {
                              // delete

                              FirebaseFirestore.instance
                                  .collection('Себет')
                                  .doc(FirebaseAuth.instance.currentUser.uid)
                                  .collection('Себет')
                                  .doc(data.id)
                                  .delete();

                              Get.snackbar(
                                "Себет",
                                "Себеттен Өшірдім",
                                icon: Icon(Icons.delete, color: Colors.black),
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Color(0xffFFDB53),
                                borderRadius: 5,
                                margin: EdgeInsets.all(15),
                                colorText: Colors.black,
                                duration: Duration(seconds: 3),
                                isDismissible: true,
                                dismissDirection: DismissDirection.horizontal,
                                forwardAnimationCurve: Curves.easeOutBack,
                              );
                            },
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

class Nav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    int totalPrice = cartProvider.subTotal();
    int quantity = cartProvider.subTotal1();

    return Container(
      height: 90,
      width: double.infinity,
      // color: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Барлығы: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
                cartProvider.getCartList.isEmpty
                    ? Text(
                        '0 ₸',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      )
                    : Text(
                        '38 940' + ' ₸',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
              ],
            ),
          ),
          cartProvider.getCartList.isEmpty
              ? Container()
              : InkWell(
                  onTap: () {
                    // on transaction
                    Get.to(TransactionView());
                  },
                  child: Container(
                    height: 40,
                    width: 180,
                    color: Color(0xffFFDB53),
                    child: Center(
                      child: Text(
                        'Жалғастыру',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class Product extends StatefulWidget {
  final String id;
  final String image;
  final String text;
  final int price;
  final int count;

  final Function addCount;
  final Function removeCount;
  final Function onDelete;

  const Product({
    Key key,
    this.id,
    this.image,
    this.text,
    this.price,
    this.count,
    this.onDelete,
    this.addCount,
    this.removeCount,
  }) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
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
                  image: NetworkImage(widget.image),
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
                        widget.text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: widget.removeCount,
                            child: Icon(
                              Icons.remove_circle,
                              size: 24,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              widget.count.toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: widget.addCount,
                            child: Icon(
                              Icons.add_circle,
                              size: 24,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 20),
                          InkWell(
                            onTap: widget.onDelete,
                            child: Icon(
                              Icons.delete,
                              size: 24,
                              color: Colors.black,
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
                widget.price.toString() + ' ₸',
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
