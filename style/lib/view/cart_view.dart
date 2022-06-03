import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:style/view/transaction_view.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              child: Container(
                child: Column(
                  children: [
                    Product(
                      image:
                          'https://image.12storeez.com/images/750xP_90_out/uploads/images/CATALOG/trousers/113828/6280dfda9b8dc-13-05-20223711.jpg',
                      text: 'Шорты джинсовые мини',
                      price: 6980,
                    ),
                    Product(
                      image:
                          'https://image.12storeez.com/images/750xP_90_out/uploads/images/CATALOG/trousers/113275/62827d1026dfc-13-05-20223052.jpg',
                      text: 'Брюки прямые мужского кроя',
                      price: 10980,
                    ),
                    Product(
                      image:
                          'https://image.12storeez.com/images/750xP_90_out/uploads/images/CATALOG/trousers/113828/6280dfda9b8dc-13-05-20223711.jpg',
                      text: 'Шорты джинсовые мини',
                      price: 6980,
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

class Nav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                Text(
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
          InkWell(
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

class Product extends StatelessWidget {
  final String image;
  final String text;
  final int price;

  const Product({Key key, this.image, this.text, this.price}) : super(key: key);

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
                        children: [
                          Icon(
                            Icons.remove_circle,
                            size: 24,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                          Icon(
                            Icons.add_circle,
                            size: 24,
                            color: Colors.black,
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
