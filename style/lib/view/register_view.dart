import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:style/view/login_view.dart';

import '../provider/register_provider.dart';

class RegisterView extends StatefulWidget {
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

TextEditingController email = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController fullName = TextEditingController();
TextEditingController phone = TextEditingController();

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = new RegExp(p);
bool obserText = true;

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    RegisterProvider registerAuthProvider =
        Provider.of<RegisterProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xffFFDB53),
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        height: 50,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // on back
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                'images/back_a.png',
                                height: 34,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Тіркелу.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            SizedBox(height: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Бізге қосылыңыз.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Бізбен бірге болыңыз!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1.5,
                                color: Color(0xff555555),
                              ),
                            ),
                            child: TextFormField(
                              controller: fullName,
                              keyboardType: TextInputType.name,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                labelText: 'Атыңыз',
                                prefixStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1.5,
                                color: Color(0xff555555),
                              ),
                            ),
                            child: TextFormField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                labelText: 'Email',
                                prefixStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1.5,
                                color: Color(0xff555555),
                              ),
                            ),
                            child: TextFormField(
                              controller: password,
                              obscureText: obserText,
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                labelText: 'Құпия сөз',
                                prefixStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(color: Colors.black),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      obserText = !obserText;
                                    });
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: Icon(
                                    obserText == true
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color(0xff555555),
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 1.5,
                                color: Color(0xff555555),
                              ),
                            ),
                            child: TextFormField(
                              controller: phone,
                              keyboardType: TextInputType.phone,
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                fillColor: Colors.black,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                labelText: 'Нөмер телефон',
                                prefixStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(color: Colors.black),
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                decorationColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Сіз тіркелгенсіз бе?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff555555),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          // on login
                          Get.to(LoginView());
                        },
                        child: Text(
                          'Кіру',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff555555),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: InkWell(
                      onTap: () {
                        // on home
                        registerAuthProvider.registerValidation(
                          email: email,
                          password: password,
                          fullName: fullName,
                          phone: phone,
                          context: context,
                        );
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xff333333),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            'Тіркелу',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
