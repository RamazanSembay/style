import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class DetailView extends StatefulWidget {
  final String id;
  final String image;
  final String text;
  final String description;
  final int price;

  const DetailView(
      {Key key, this.id, this.image, this.text, this.price, this.description})
      : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###');

    return Scaffold(
      bottomNavigationBar: DetailNav(
        text: widget.price,
        onTap: () {
          // on cart
          FirebaseFirestore.instance
              .collection('Себет')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .collection('Себет')
              .doc(widget.id)
              .set({
            'Id': widget.id,
            'Название': widget.text,
            'Картинка': widget.image,
            'Цена': widget.price,
            'Описание': widget.description,
            'Количество': 1
          });

          Get.snackbar(
            'Себет',
            'Сіз тауарды себетке қостыңыз ' + widget.text,
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
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        'Ақпарат',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 250,
                  width: 200,
                  child: Image(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover,
                    height: 250,
                    width: 200,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          widget.text,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // on favorite
                        FirebaseFirestore.instance
                            .collection('Ұнағандар')
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection('Ұнағандар')
                            .doc(widget.id)
                            .set({
                          'Id': widget.id,
                          'Название': widget.text,
                          'Картинка': widget.image,
                          'Цена': widget.price,
                          'Описание': widget.description,
                        });

                        Get.snackbar(
                          'Ұнағандар',
                          'Сіз осы тауарды ұнады ' + widget.text,
                          icon: Icon(Icons.favorite, color: Colors.black),
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
                      child: Icon(
                        Icons.favorite,
                        size: 34,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      widget.description,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Color(0xff999999),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailNav extends StatelessWidget {
  final int text;
  final Function onTap;

  const DetailNav({Key key, this.text, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###');

    return Container(
      height: 80,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      '${formatter.format(text.toInt()) + ' ₸'}'
                          .replaceAll(',', ' '),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: onTap,
                  child: Container(
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            width: 180,
                            decoration: BoxDecoration(
                              color: Color(0xffFFD954),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: Text(
                                'Себетке салу',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
