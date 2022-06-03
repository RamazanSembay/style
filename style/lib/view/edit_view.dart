import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:style/service/firebase_services.dart';

class EditView extends StatefulWidget {
  final String city;
  final String street;
  final int home;

  const EditView({Key key, this.city, this.street, this.home})
      : super(key: key);

  @override
  State<EditView> createState() => _EditViewState();
}

final city = TextEditingController();
final street = TextEditingController();
final home = TextEditingController();

class _EditViewState extends State<EditView> {
  bool _isLoading = false;

  FirebaseServices _services = FirebaseServices();

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
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      bottomNavigationBar: InkWell(
        onTap: () {
          // on edit profile
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
          child: InkWell(
            onTap: () {
              // on edit
              if (city.text.trim().isEmpty) {
                Get.snackbar(
                  "Қала",
                  "Сіз өз қалаңызды енгізбедіңіз",
                  icon: Icon(Icons.edit, color: Colors.black),
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Color(0xffFFDB53),
                  borderRadius: 5,
                  margin: EdgeInsets.all(15),
                  colorText: Colors.black,
                  duration: Duration(seconds: 3),
                  isDismissible: true,
                  dismissDirection: DismissDirection.horizontal,
                  forwardAnimationCurve: Curves.easeOutBack,
                );
                return;
              } else {
                if (street.text.trim().isEmpty) {
                  Get.snackbar(
                    'Көше',
                    'Сіз өз көшеңізді енгізбедіңіз',
                    icon: Icon(Icons.edit, color: Colors.black),
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Color(0xffFFDB53),
                    borderRadius: 5,
                    margin: EdgeInsets.all(15),
                    colorText: Colors.black,
                    duration: Duration(seconds: 3),
                    isDismissible: true,
                    dismissDirection: DismissDirection.horizontal,
                    forwardAnimationCurve: Curves.easeOutBack,
                  );
                  return;
                }
                if (home.text.trim().isEmpty) {
                  Get.snackbar(
                    'Қаланы толтырыңыз',
                    'Сіз өз үйдің нөмерің енгізбедіңіз',
                    icon: Icon(Icons.edit, color: Colors.black),
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Color(0xffFFDB53),
                    borderRadius: 5,
                    margin: EdgeInsets.all(15),
                    colorText: Colors.black,
                    duration: Duration(seconds: 3),
                    isDismissible: true,
                    dismissDirection: DismissDirection.horizontal,
                    forwardAnimationCurve: Curves.easeOutBack,
                  );
                  return;
                } else {
                  setState(() {
                    _isLoading = true;
                  });
                  _services.addUserData(
                    data: {
                      'Город': city.text,
                      'Адрес': street.text,
                      'Дом': home.text,
                    },
                  );
                  Navigator.pop(context);
                  city.text = '';
                  street.text = '';
                  home.text = '';
                }
              }
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
                  'Өзгерту',
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
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
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
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Text(
                      'Өзгерту',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        controller: city,
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
                          labelText: 'Қала',
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
                        controller: street,
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
                          labelText: 'Көше',
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
                        controller: home,
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
                          labelText: 'Үйдің нөмері',
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
        ],
      ),
    );
  }
}
