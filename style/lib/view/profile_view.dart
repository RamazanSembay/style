import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:style/view/edit_view.dart';
import 'package:style/view/home_view.dart';
import 'package:style/view/my_product_view.dart';
import 'package:style/view/my_success_view.dart';

class ProfileView extends StatefulWidget {
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User user = FirebaseAuth.instance.currentUser;
  DocumentSnapshot vendorData;

  @override
  void initState() {
    getVendorData();
    super.initState();
  }

  Future<DocumentSnapshot> getVendorData() async {
    var result = await FirebaseFirestore.instance
        .collection('Пользователь')
        .doc(user.uid)
        .get();
    setState(() {
      vendorData = result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Center(
            child: Text(
              'Профилім',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          SizedBox(height: 50),

          // Account name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  vendorData != null ? vendorData.data()['Имя'] : '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
                InkWell(
                  onTap: () {
                    // on edit
                    Get.to(EditView());
                  },
                  child: Icon(
                    Icons.edit,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),

          // Мен туралы
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Мен туралы',
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Қала:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          vendorData != null ? vendorData.data()['Город'] : '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Көше:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          vendorData != null ? vendorData.data()['Адрес'] : '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Үй:',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        Text(
                          vendorData != null ? vendorData.data()['Дом'] : '',
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
              ],
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Менің әрекеттерім',
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    // Менің төлемдерім
                    InkWell(
                      onTap: () {
                        // on success
                        Get.to(MySuccessView());
                      },
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage('images/payment.png'),
                            height: 50,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Менің төлемдерім',
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
                            ),
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 20,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // Менің тапсырыстарым
                    InkWell(
                      onTap: () {
                        // on my product
                        Get.to(MyProductView());
                      },
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage('images/order.png'),
                            height: 50,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                height: 50,
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Менің тапсырыстарым',
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
                            ),
                          ),
                          Icon(
                            Icons.navigate_next,
                            size: 20,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Менің аккаунтім',
                  style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    // on signout
                    FirebaseAuth.instance.signOut();
                    Get.to(HomeView());
                  },
                  child: Text(
                    'Аккаунттан шығу',
                    style: TextStyle(
                      color: Color(0xffE70B0B),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
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
