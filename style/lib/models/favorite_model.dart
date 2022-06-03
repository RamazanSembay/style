import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel {
  final String id;
  final String text;
  final String image;
  final String description;
  final int price;

  FavoriteModel({
    this.id,
    this.text,
    this.image,
    this.description,
    this.price,
  });

  factory FavoriteModel.fromDocument(QueryDocumentSnapshot doc) {
    return FavoriteModel(
      id: doc["Id"],
      text: doc["Название"],
      image: doc["Картинка"],
      description: doc["Описание"],
      price: doc["Цена"],
    );
  }
}
