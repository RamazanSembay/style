import 'package:flutter/material.dart';
import 'package:style/view/cart_view.dart';
import 'package:style/view/home_view.dart';
import 'package:style/view/profile_view.dart';
import 'package:style/view/search_view.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  PageController _tabsController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Bottom(
        selectedTab: _selectedTab,
        tabPressed: (num) {
          setState(
            () {
              _tabsController.animateToPage(num,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
            },
          );
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _tabsController,
              onPageChanged: (num) {
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                HomeView(),
                SearchView(),
                CartView(),
                ProfileView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Bottom extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  Bottom({this.selectedTab, this.tabPressed});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabs(
            image: 'icon/home.png',
            text: 'Басты бет',
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottomTabs(
            image: 'icon/search.png',
            text: 'Іздеу',
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottomTabs(
            image: 'icon/cart.png',
            text: 'Себет',
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
          BottomTabs(
            image: 'icon/person.png',
            text: 'Профиль',
            selected: _selectedTab == 3 ? true : false,
            onPressed: () {
              widget.tabPressed(3);
            },
          ),
        ],
      ),
    );
  }
}

class BottomTabs extends StatelessWidget {
  final String image;
  final String text;
  final bool selected;
  final Function onPressed;
  BottomTabs({this.image, this.text, this.selected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        height: 60,
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              color: Colors.black,
              image: AssetImage(image),
              width: 24,
              height: 24,
            ),
            Text(
              '${_selected ? text : ''}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 9,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
