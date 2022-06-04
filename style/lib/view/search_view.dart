import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:style/view/detail_view.dart';

import 'package:intl/intl.dart';

class SearchView extends StatefulWidget {
  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String query = '';
  var result;
  searchFunction(query, searchList) {
    result = searchList.where((element) {
      return element["Название"].toUpperCase().contains(query) ||
          element["Название"].toLowerCase().contains(query) ||
          element["Название"].toUpperCase().contains(query) &&
              element["Название"].toLowerCase().contains(query);
    }).toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Өзіңіздің қалаған нәрсені іздеңіз',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffEEEEEE),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                style: TextStyle(
                  color: Color(0xff888888),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  border: InputBorder.none,
                  hintText: 'Іздеу',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff999999),
                  ),
                  hintStyle: TextStyle(
                    color: Color(0xff888888),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: Column(
                  children: [
                    FutureBuilder<QuerySnapshot>(
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
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        return Expanded(
                          child: Container(
                            child: query == ''
                                ? StaggeredGridView.countBuilder(
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    itemCount: snapshot.data.docs.length,
                                    staggeredTileBuilder: (index) =>
                                        StaggeredTile.fit(1),
                                    mainAxisSpacing: 15.0,
                                    crossAxisSpacing: 15.0,
                                    itemBuilder: (context, index) {
                                      var varData = searchFunction(
                                          query, snapshot.data.docs);

                                      var data = varData[index];

                                      return Product(
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
                                      );
                                    },
                                  )
                                : StaggeredGridView.countBuilder(
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    itemCount: snapshot.data.docs.length,
                                    staggeredTileBuilder: (index) =>
                                        StaggeredTile.fit(1),
                                    mainAxisSpacing: 15.0,
                                    crossAxisSpacing: 15.0,
                                    itemBuilder: (context, index) {
                                      var varData = searchFunction(
                                          query, snapshot.data.docs);

                                      var data = varData[index];

                                      return result.isEmpty
                                          ? Container()
                                          : Product(
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
                                            );
                                    },
                                  ),
                          ),
                        );
                      },
                    ),
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

class Product extends StatelessWidget {
  final String image;
  final String text;
  final int price;
  final Function onTap;

  const Product({Key key, this.image, this.text, this.price, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,###');

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  child: Image(
                    image: NetworkImage(image),
                    height: 150,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
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
            SizedBox(height: 20),
            Text(
              '${formatter.format(price.toInt()) + ' ₸'}'.replaceAll(',', ' '),
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
