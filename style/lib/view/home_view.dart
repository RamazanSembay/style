import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:style/view/detail_view.dart';
import 'package:style/view/information_view.dart';
import 'package:style/view/login_view.dart';

import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    var formatter = NumberFormat('#,###');

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Менің орналасқан жерім',
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.expand_more,
                              color: Color(0xff999999),
                              size: 18,
                            ),
                          ],
                        ),
                        SizedBox(height: 9),
                        Text(
                          vendorData != null
                              ? vendorData.data()['Город']
                              : 'Толтырыңыз',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    Image(
                      image: AssetImage('images/favorite.png'),
                      height: 40,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        // womens
                        Category(
                          image:
                              'https://cdnkz.ostin.com/upload/mdm/media_content/resize/50e/686_950_c73f/63746840299.jpg',
                          text: 'Әйелдер',
                          onTap: () {
                            // on information
                            Get.to(InformationView(
                              title: 'Әйелдер',
                              collectionPath: 'Әйелдер',
                            ));
                          },
                        ),

                        // mens

                        Category(
                          image:
                              'https://cdnkz.ostin.com/upload/mdm/media_content/resize/09c/332_460_3af3/63893530299.jpg',
                          text: 'Ерлер',
                          onTap: () {
                            // on information
                            Get.to(InformationView(
                              title: 'Ерлер',
                              collectionPath: 'Ерлер',
                            ));
                          },
                        ),

                        // girl
                        Category(
                          image:
                              'https://cdnkz.ostin.com/upload/mdm/media_content/resize/1af/686_950_73d6/62031260299.jpg',
                          text: 'Қыздар',
                          onTap: () {
                            // on information
                            Get.to(InformationView(
                              title: 'Қыздар',
                              collectionPath: 'Қыздар',
                            ));
                          },
                        ),

                        // boy
                        Category(
                          image:
                              'https://cdnkz.ostin.com/upload/mdm/media_content/resize/69f/686_950_2338/61922450299.jpg',
                          text: 'Ұлдар',
                          onTap: () {
                            // on information
                            Get.to(InformationView(
                              title: 'Ұлдар',
                              collectionPath: 'Ұлдар',
                            ));
                          },
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
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Қазір Трендте',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // on information
                                Get.to(InformationView(
                                  title: 'Қазір Трендте',
                                  collectionPath: 'Қазір Трендте',
                                ));
                              },
                              child: Icon(
                                Icons.navigate_next,
                                size: 34,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Кез келген стильде киінуге',
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Container(
                      height: 240,
                      width: double.infinity,
                      child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('Қазір Трендте')
                            .get(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data.docs[index];
                              return Row(
                                children: [
                                  Trend(
                                    image: data['Картинка'],
                                    text: data['Название'],
                                    price: data['Цена'],
                                    onTap: () {
                                      // on detail
                                      Get.to(DetailView(
                                        id: data['Id'],
                                        image: data['Картинка'],
                                        text: data['Название'],
                                        price: data['Цена'],
                                        description: data['Описание'],
                                      ));
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),

              // Ерлерге
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ерлерге',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // on information
                                Get.to(InformationView(
                                  title: 'Ерлерге',
                                  collectionPath: 'Ерлерге',
                                ));
                              },
                              child: Icon(
                                Icons.navigate_next,
                                size: 34,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Кез-келген ауа-райы үшін',
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Container(
                      height: 240,
                      width: double.infinity,
                      child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('Ерлерге')
                            .get(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data.docs[index];
                              return Row(
                                children: [
                                  Trend(
                                    image: data['Картинка'],
                                    text: data['Название'],
                                    price: data['Цена'],
                                    onTap: () {
                                      // on detail
                                      Get.to(DetailView(
                                        id: data['Id'],
                                        image: data['Картинка'],
                                        text: data['Название'],
                                        price: data['Цена'],
                                        description: data['Описание'],
                                      ));
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),

              // Әйелдерге
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Әйелдерге',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // on information
                                Get.to(InformationView(
                                  title: 'Әйелдерге',
                                  collectionPath: 'Әйелдерге',
                                ));
                              },
                              child: Icon(
                                Icons.navigate_next,
                                size: 34,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Кез-келген әйелдер үшін',
                          style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    Container(
                      height: 240,
                      width: double.infinity,
                      child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('Әйелдерге')
                            .get(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          return ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data.docs[index];
                              return Row(
                                children: [
                                  Trend(
                                    image: data['Картинка'],
                                    text: data['Название'],
                                    price: data['Цена'],
                                    onTap: () {
                                      // on detail
                                      Get.to(DetailView(
                                        id: data['Id'],
                                        image: data['Картинка'],
                                        text: data['Название'],
                                        price: data['Цена'],
                                        description: data['Описание'],
                                      ));
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image;
  final String text;
  final Function onTap;

  const Category({Key key, this.image, this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Color(0xffF9D264),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    image,
                    height: 45.0,
                    width: 45.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Trend extends StatelessWidget {
  final String image;
  final String text;
  final int price;
  final Function onTap;

  const Trend({Key key, this.image, this.text, this.price, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  child: Image(
                    image: NetworkImage(image),
                    height: 130,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 150,
                  height: 40,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              price.toString() + ' ₸',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
