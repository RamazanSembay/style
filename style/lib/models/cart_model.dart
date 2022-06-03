import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String id;
  final String text;
  final String image;
  final String description;
  final int price;
  final int count;

  CartModel({
    this.id,
    this.text,
    this.image,
    this.description,
    this.price,
    this.count,
  });

  factory CartModel.fromDocument(QueryDocumentSnapshot doc) {
    return CartModel(
      id: doc["Id"],
      text: doc["Название"],
      image: doc["Картинка"],
      price: doc["Цена"],
      description: doc["Описание"],
      count: doc["Количество"],
    );
  }
}
