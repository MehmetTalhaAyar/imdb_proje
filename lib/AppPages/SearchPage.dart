import 'package:flutter/material.dart';
import 'package:imdb_proje/Functions/bottomNavigationBar.dart';
import 'package:imdb_proje/Functions/firebaseAndFire.dart';
import 'package:imdb_proje/modeller/movieItem.dart';

import '../Classes/movieClass.dart';
import '../Classes/userClass.dart';

class SearchPage extends StatefulWidget {
  User suankiUser;
  List<Movie> allMovies;
  List<Movie> searchingMovies = [];
  final PageStorageKey searchPageKey = PageStorageKey("1");

  SearchPage({Key? key, required this.suankiUser, required this.allMovies})
      : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _formKey = GlobalKey<FormState>();
  String arananVeri = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.teal,
        leading: GestureDetector(
          child: Icon(
            Icons.search_outlined,
            color: Colors.amber,
          ),
          onTap: () {
            bool _validate = _formKey.currentState!.validate();
            if (_validate) {
              // print(arananVeri);
              _formKey.currentState!.save();
              _stringSearch();
              // print(widget.searchingMovies.length);
            }
          },
        ),
        title: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: TextFormField(
              cursorColor: Colors.red,
              focusNode: FocusNode(),
              validator: (deger) {
                if (deger!.length < 1) {
                  return "";
                }
              },
              onSaved: (value) {
                arananVeri = value!;
              },
            )),
      ),
      bottomNavigationBar: myBottomNavigationBar(
        pageKey: widget.searchPageKey,
        currentIndex: 1,
        suankiUser: widget.suankiUser,
        allMovies: widget.allMovies,
      ),
      body: ListView.builder(
        itemCount: widget.searchingMovies.length,
        itemBuilder: (BuildContext context, int index) {
          return movieItem(
              myMovie: widget.searchingMovies[index],
              myfunc: () {
                if (!widget.suankiUser.userMovieListString!
                    .contains(widget.searchingMovies[index].movieName)) {
                  widget.suankiUser.userMovieListString!
                      .add(widget.searchingMovies[index].movieName);
                  widget.suankiUser.userMovieList
                      ?.add(widget.searchingMovies[index]);
                  saveMovieListTheDatabase();
                }
              });
        },
      ),
    );
  }

  saveMovieListTheDatabase() {
    List<String> newUserMovieList = [];

    for (int i = 0; i < widget.suankiUser.userMovieList!.length; i++) {
      newUserMovieList.add(widget.suankiUser.userMovieList![i].movieName);
    }

    FirebaseAndFire.addToYourList(
        widget.suankiUser.e_mail, newUserMovieList, 1);
  }

  _stringSearch() async {
    var movieRef = await FirebaseAndFire.firestore.collection("movies");
    var stringSearch = await movieRef
        .orderBy("movieName")
        .startAfter([
          arananVeri.substring(0, 1).toUpperCase() + arananVeri.substring(1)
        ])
        .limit(10)
        .get();
    for (var eleman in stringSearch.docs) {
      // print(eleman.data()["movieName"].toString());
      setState(() {
        widget.searchingMovies.add(Movie(
            movieName: eleman.data()["movieName"].toString(),
            movieRate: eleman.data()["movieRate"],
            movieDescription: eleman.data()["movieDescription"].toString(),
            movieDirector: eleman.data()["movieDirector"].toString(),
            movieStars: eleman.data()["movieStars"].toString(),
            movieSmallImageURL: eleman.data()["movieImageUrl"].toString()));
      });
    }
  }
}
