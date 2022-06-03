import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../provider/favorite_provider.dart';

class FavoriteView extends StatefulWidget {
  final String title;
  final String collectionPath;

  const FavoriteView({Key key, this.title, this.collectionPath})
      : super(key: key);
  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);
    favoriteProvider.getFavoriteData();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
              child: favoriteProvider.getFavoriteList.isEmpty
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
                          'Сізге ешқандай тауар ұнаған жоқ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ))
                  : Expanded(
                      child: Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: favoriteProvider.getFavoriteList.length,
                          itemBuilder: (context, index) {
                            var data = favoriteProvider.getFavoriteList[index];
                            return Product(
                              id: data.id,
                              image: data.image,
                              text: data.text,
                              price: data.price,
                            );
                          },
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

  const Product({
    Key key,
    this.id,
    this.image,
    this.text,
    this.price,
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
