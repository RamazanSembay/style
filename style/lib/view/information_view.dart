import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import 'package:intl/intl.dart';
import 'package:style/view/detail_view.dart';

class InformationView extends StatefulWidget {
  final String title;
  final String collectionPath;

  const InformationView({Key key, this.title, this.collectionPath})
      : super(key: key);

  @override
  State<InformationView> createState() => _InformationViewState();
}

class _InformationViewState extends State<InformationView> {
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
                        widget.title,
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
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: Column(
                  children: [
                    FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection(widget.collectionPath)
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
                            // height: 500,
                            child: StaggeredGridView.countBuilder(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              itemCount: snapshot.data.docs.length,
                              staggeredTileBuilder: (index) =>
                                  StaggeredTile.fit(1),
                              mainAxisSpacing: 15.0,
                              crossAxisSpacing: 15.0,
                              itemBuilder: (context, index) {
                                var data = snapshot.data.docs[index];

                                return InfoProduct(
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
          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class InfoProduct extends StatelessWidget {
  final String image;
  final String text;
  final int price;
  final Function onTap;

  const InfoProduct({Key key, this.image, this.text, this.price, this.onTap})
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
