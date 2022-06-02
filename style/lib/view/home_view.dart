import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                      image: AssetImage('images/cart.png'),
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
                        ),

                        // mens

                        Category(
                          image:
                              'https://cdnkz.ostin.com/upload/mdm/media_content/resize/09c/332_460_3af3/63893530299.jpg',
                          text: 'Ерлер',
                        ),

                        // girl
                        Category(
                          image:
                              'https://cdnkz.ostin.com/upload/mdm/media_content/resize/1af/686_950_73d6/62031260299.jpg',
                          text: 'Қыздар',
                        ),

                        // boy
                        Category(
                          image:
                              'https://cdnkz.ostin.com/upload/mdm/media_content/resize/69f/686_950_2338/61922450299.jpg',
                          text: 'Ұлдар',
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
                            Icon(
                              Icons.navigate_next,
                              size: 34,
                              color: Colors.black,
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
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Trend(
                                    image:
                                        'https://image.12storeez.com/images/720xP_90_out/uploads/images/LookBook/15-3-22/623050f92c64c-06-000007870033.jpg',
                                    text: 'Кардиган на молнии',
                                    price: 16500,
                                  ),
                                  Trend(
                                    image:
                                        'https://image.12storeez.com/images/720xP_90_out/uploads/images/LookBook/15-3-22/6230511499094-06-000007870009.jpg',
                                    text: 'Рубашка льняная',
                                    price: 9800,
                                  ),
                                  Trend(
                                      image:
                                          'https://image.12storeez.com/images/720xP_90_out/uploads/images/LookBook/15-3-22/623051303c71c-08-000008010018.jpg',
                                      text: 'Толстовка',
                                      price: 7980),
                                ],
                              ),
                            ],
                          ),
                        ],
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
                            Icon(
                              Icons.navigate_next,
                              size: 34,
                              color: Colors.black,
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
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Trend(
                                    image:
                                        'https://image.12storeez.com/images/750xP_90_out/uploads/images/CATALOG/mens-collection/114559/6284e771e5511-11-05-20221839.jpg',
                                    text: 'Рубашка льняная',
                                    price: 9980,
                                  ),
                                  Trend(
                                    image:
                                        'https://image.12storeez.com/images/750xP_90_out/uploads/images/CATALOG/mens-collection/114219/627b783cc672c-04-05-20220464.jpg',
                                    text: 'Брюки свободные со складками',
                                    price: 9890,
                                  ),
                                  Trend(
                                      image:
                                          'https://image.12storeez.com/images/750xP_90_out/uploads/images/CATALOG/mens-collection/114211/627b740c21f9b-04-05-20220079.jpg',
                                      text: 'Шорты свободные со складками',
                                      price: 7980),
                                ],
                              ),
                            ],
                          ),
                        ],
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
                            Icon(
                              Icons.navigate_next,
                              size: 34,
                              color: Colors.black,
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
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Trend(
                                    image:
                                        'https://image.12storeez.com/images/750xP_90_out/uploads/images/CATALOG/jackets/114186/6295bcbf587a5-20-05-20229870.jpg',
                                    text: 'Жакет льняной двубортный',
                                    price: 15980,
                                  ),
                                  Trend(
                                    image:
                                        'https://image.12storeez.com/images/750xP_90_out/uploads/images/CATALOG/trousers/114425/62953828f072e-20-05-20229478.jpg',
                                    text: 'Брюки льняные в мужском стиле',
                                    price: 10980,
                                  ),
                                  Trend(
                                    image:
                                        'https://image.12storeez.com/images/750xP_90_out/uploads/images/CATALOG/trousers/113828/6280dfda9b8dc-13-05-20223711.jpg',
                                    text: 'Шорты джинсовые мини',
                                    price: 6980,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
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

  const Category({Key key, this.image, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}

class Trend extends StatelessWidget {
  final String image;
  final String text;
  final int price;

  const Trend({Key key, this.image, this.text, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
