import 'package:flutter/material.dart';
import 'package:imdb_proje/Classes/movieClass.dart';
import 'package:imdb_proje/Classes/userClass.dart';
import 'package:imdb_proje/Functions/bottomNavigationBar.dart';
import 'package:imdb_proje/Functions/firebaseAndFire.dart';
import 'package:imdb_proje/modeller/movieItem.dart';

class HomePage extends StatelessWidget {
  User suankiUser;
  List<Movie> allMovies;

  final PageStorageKey homePageKey = PageStorageKey("0");
  HomePage({Key? key, required this.suankiUser, required this.allMovies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: myBottomNavigationBar(
        allMovies: allMovies,
        pageKey: homePageKey,
        currentIndex: 0,
        suankiUser: suankiUser,
      ),
      appBar: AppBar(
          title: Text("Home Page"),
          centerTitle: true,
          automaticallyImplyLeading: false),
      body: listViewCreator(),
    );
  }

  ListView listViewCreator() {
    return ListView.builder(
        itemCount: allMovies.length,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {},
            child: movieItem(
              myfunc: () {
                if (!suankiUser.userMovieListString!
                    .contains(allMovies[index].movieName)) {
                  suankiUser.userMovieListString!
                      .add(allMovies[index].movieName);
                  suankiUser.userMovieList?.add(allMovies[index]);
                  saveMovieListTheDatabase();
                }
              },
              myMovie: allMovies[index],
            ),
          );
        });
  }

  saveMovieListTheDatabase() {
    List<String> newUserMovieList = [];

    for (int i = 0; i < suankiUser.userMovieList!.length; i++) {
      newUserMovieList.add(suankiUser.userMovieList![i].movieName);
    }

    FirebaseAndFire.addToYourList(suankiUser.e_mail, newUserMovieList, 1);
  }
}
