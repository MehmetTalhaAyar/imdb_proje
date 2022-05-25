import 'package:flutter/material.dart';
import 'package:imdb_proje/Classes/commentClass.dart';
import 'package:imdb_proje/Classes/movieClass.dart';
import 'package:imdb_proje/Functions/bottomNavigationBar.dart';
import 'package:imdb_proje/Classes/userClass.dart';
import 'package:imdb_proje/Functions/firebaseAndFire.dart';
import 'package:imdb_proje/modeller/movieItem.dart';

class AccountPage extends StatelessWidget {
  final User suankiUser;
  List<Movie> allMovies;
  final PageStorageKey accountPageKey = PageStorageKey("2");
  AccountPage({required this.suankiUser, required this.allMovies, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //puanladıklarım ve listem aynı row içinden çıkarılacak
    //column bi singlechildscrollview içine alınacak
    Movie _secilenMovie;

    return Scaffold(
      //baska dosyaya alınabilir.
      endDrawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
              // currentAccountPicture: , buraya resim konulabilir
              accountName: Text(suankiUser.getName),
              accountEmail: Text(suankiUser.e_mail)),
          Expanded(
            child: ListView(
              children: [
                InkWell(
                  splashColor: Colors.grey,
                  onTap: () {
                    Navigator.pushNamed(context, "/HomePage",
                        arguments: [suankiUser, allMovies]);
                  },
                  child: ListTile(
                    title: Text("Ana sayfa"),
                    subtitle: Text("Ana sayfaya gider"),
                  ),
                ),
                Divider(),
                InkWell(
                  splashColor: Colors.orange,
                  onTap: () {
                    FirebaseAndFire.signOutUser();

                    Navigator.pushNamedAndRemoveUntil(
                        context, "/SignInPage", (route) => false);
                  },
                  child: ListTile(
                    title: Text("Cikis Yap"),
                    subtitle: Text(""),
                  ),
                ),
                Divider(),
                // InkWell(
                //   onTap: () {
                //     FirebaseAndFire.readMovieCollection();
                //   },
                //   child: ListTile(title: Text("Read Movie")),
                // ),
                // Divider()
              ],
            ),
          )
        ]),
      ),
      bottomNavigationBar: myBottomNavigationBar(
        allMovies: allMovies,
        pageKey: accountPageKey,
        currentIndex: 2,
        suankiUser: suankiUser,
      ),
      //scaffold hepsinde aynı kalacak
      appBar: AppBar(
          leading: Icon(Icons.keyboard_option_key),
          automaticallyImplyLeading: false,
          centerTitle: true,
          //Kullanici Adi
          title: Text("Hello " + suankiUser.getName)),
      body: ColoredBox(
        color: Colors.grey.shade400,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListTile(
                      title: Row(
                        children: [
                          Icon(Icons.add),
                          Text(
                            "Your List",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      subtitle: Container(
                        color: Colors.teal,
                        height: 225,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                _secilenMovie =
                                    suankiUser.userMovieList![index];
                                getAllComments(_secilenMovie);
                                Navigator.pushNamed(context, "/MoviePage",
                                    arguments: [_secilenMovie, suankiUser]);
                              },
                              child: movieItem(
                                  myMovie: suankiUser.userMovieList![index],
                                  myfunc: () {
                                    _secilenMovie =
                                        suankiUser.userMovieList![index];

                                    if (!suankiUser.userWatchListString!
                                        .contains(_secilenMovie.movieName)) {
                                      suankiUser.userMovieListString!
                                          .remove(_secilenMovie.movieName);

                                      suankiUser.userWatchList!
                                          .add(_secilenMovie);
                                      suankiUser.userMovieList!
                                          .remove(_secilenMovie);
                                      saveTheDatabase();
                                      saveMovieListTheDatabase();
                                    }
                                  }),
                            );
                          },
                          itemCount: suankiUser.userMovieList?.length,
                        ),
                      )),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: ListTile(
                title: Row(children: [
                  Icon(Icons.add),
                  Text(
                    "Your Watch List",
                    style: TextStyle(fontSize: 18),
                  )
                ]),
                subtitle: Container(
                  height: 225,
                  color: Colors.teal,
                  child: ListView.builder(
                    itemCount: suankiUser.userWatchList!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (() {
                          _secilenMovie = suankiUser.userWatchList![index];
                          if (_secilenMovie.movieCommentList.length == 0) {
                            getAllComments(_secilenMovie);
                          }

                          Navigator.pushNamed(context, "/MoviePage",
                              arguments: [_secilenMovie, suankiUser]);
                        }),
                        child: movieItem(
                            myMovie: suankiUser.userWatchList![index],
                            myfunc: () {}),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  saveTheDatabase() async {
    List<String> newWatchList = [];
    for (int i = 0; i < suankiUser.userWatchList!.length; i++) {
      newWatchList.add(suankiUser.userWatchList![i].movieName);
    }

    FirebaseAndFire.addToWatchList(suankiUser.e_mail, newWatchList, 1);
  }

  saveMovieListTheDatabase() {
    List<String> newUserMovieList = [];

    for (int i = 0; i < suankiUser.userMovieList!.length; i++) {
      newUserMovieList.add(suankiUser.userMovieList![i].movieName);
    }

    FirebaseAndFire.addToYourList(suankiUser.e_mail, newUserMovieList, -1);
  }

  getAllComments(Movie myMovie) async {
    var commentsDoc = await FirebaseAndFire.firestore
        .collection("comments")
        .where("movieName", isEqualTo: myMovie.movieName)
        .get();
    for (var eleman in commentsDoc.docs) {
      var newComment = Comment(eleman.data()["username"].toString(),
          eleman.data()["comment"].toString());

      newComment.likeCount = eleman.data()["likeCount"];
      print(eleman.data()["comment"]);
      for (int i = 0; i < newComment.likeCount; i++) {
        newComment.userWhoLikedTheComment
            .add(eleman.data()["userWhoLikedTheComment"][i]);
      }
      myMovie.movieCommentList.add(newComment);
    }
  }
}
