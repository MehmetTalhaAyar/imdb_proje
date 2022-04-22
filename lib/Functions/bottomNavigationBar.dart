import 'package:flutter/material.dart';

class myBottomNavigationBar extends StatefulWidget {
  myBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<myBottomNavigationBar> createState() => _myBottomNavigationBarState();
}

class _myBottomNavigationBarState extends State<myBottomNavigationBar> {
  int _bottomNavigationBarCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: ((int index) {
          setState(() {
            _bottomNavigationBarCurrentIndex = index;
          });
          // if (bottomNavigationBarCurrentIndex == 1) {
          //   Navigator.pushNamed(context, "/RegisterPage");
          // }
        }),
        showUnselectedLabels: false,
        currentIndex: _bottomNavigationBarCurrentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Bilmem"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle_outlined,
              ),
              label: "Hello2"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_card_outlined), label: "Hello")
        ]);
  }
}
