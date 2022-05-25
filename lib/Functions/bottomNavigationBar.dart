import 'package:flutter/material.dart';

import '../Classes/movieClass.dart';
import '../Classes/userClass.dart';

class myBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final User suankiUser;
  List<Movie> allMovies;
  PageStorageKey pageKey;
  myBottomNavigationBar(
      {required this.pageKey,
      required this.currentIndex,
      required this.suankiUser,
      required this.allMovies})
      : super(key: pageKey);

  @override
  State<myBottomNavigationBar> createState() => _myBottomNavigationBarState();
}

class _myBottomNavigationBarState extends State<myBottomNavigationBar> {
  late int _bottomNavigationBarCurrentIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bottomNavigationBarCurrentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: Colors.blue,
        backgroundColor: Colors.greenAccent,
        unselectedItemColor: Colors.red.shade300,
        key: widget.pageKey,
        onTap: ((int index) {
          setState(() {
            _bottomNavigationBarCurrentIndex = index;
          });
          switch (_bottomNavigationBarCurrentIndex) {
            case 0:
              Navigator.pushNamed(context, "/HomePage",
                  arguments: [widget.suankiUser, widget.allMovies]);
              break;
            case 1:
              Navigator.pushNamed(context, "/SearchPage",
                  arguments: [widget.suankiUser, widget.allMovies]);
              break;
            case 2:
              Navigator.pushNamed(context, "/AccountPage",
                  arguments: [widget.suankiUser, widget.allMovies]);
          }

          //buraya sayfalar arası gecis yapabilmek icin bi switch case yapısı
        }),
        showUnselectedLabels: false,
        currentIndex: _bottomNavigationBarCurrentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "Account"),
        ]);
  }
}
