import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:style/view/auth_view.dart';
import 'package:style/view/login_view.dart';

class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Image(
                image: NetworkImage(
                    'https://image.12storeez.com/images/720xP_90_out/uploads/images/LookBook/15-3-22/623051303c71c-08-000008010018.jpg'),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: 350,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Стильде болыңыз!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Ең өзіңіз іздеп жүрген стилді  біздің барлық дүкендерімізден тапсырыс бере аласыз!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff999999),
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      // on auth
                      Get.to(AuthView());
                    },
                    child: Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffFFDB53),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          'Жалғастыру'.toUpperCase(),
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
          ),
        ],
      ),
    );
  }
}
