import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:style/view/home_view.dart';

import '../widget/nav_bar.dart';

class LoginProvider with ChangeNotifier {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(LoginProvider.pattern.toString());
  UserCredential userCredential;

  void loginValidation({
    TextEditingController email,
    TextEditingController password,
    BuildContext context,
  }) async {
    if (!regExp.hasMatch(email.text.trim())) {
      Get.snackbar(
        'Заполните почта',
        'Вы не ввели электронной почты!',
        snackPosition: SnackPosition.TOP,
      );
      return;
    } else {
      if (password.text.trim().isEmpty) {
        Get.snackbar(
          'Заполните пароль',
          'Вы не ввели пароль!',
          snackPosition: SnackPosition.TOP,
        );
        return;
      } else {
        if (password.text.length <= 8) {
          Get.snackbar(
            'Текстовой поля ',
            'Пароль должен быть 8!',
            snackPosition: SnackPosition.TOP,
          );
          return;
        } else {
          try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: email.text,
              password: password.text,
            );
            email.text = '';
            password.text = '';
            Get.to(NavBar());
          } on FirebaseAuthException catch (e) {
            if (e.code == "week-password") {
              Get.snackbar(
                'Просмотр пароля',
                'Слабый пароль',
                snackPosition: SnackPosition.TOP,
              );
            } else if (e.code == 'email-already-in-user') {
              Get.snackbar(
                'Проверка',
                'Электронная почта, которая уже используется',
                snackPosition: SnackPosition.TOP,
              );
            }
          }
        }
      }
    }
  }
}
