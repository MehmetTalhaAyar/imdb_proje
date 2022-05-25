import 'package:flutter/material.dart';
import 'package:imdb_proje/Classes/userClass.dart';
import 'package:imdb_proje/Functions/firebaseAndFire.dart';

import '../Classes/movieClass.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

//sayfanın en altına belki birsey daha koyarız.
class _SignInPageState extends State<SignInPage> {
  String _email = "";
  String _password = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //app barı kaldırmayı dusunuyorum.
      appBar:
          //icon bulabilirsek uygulama iconu olacak.
          //renkler ayarlanacak.
          AppBar(leading: Icon(Icons.add), title: Text("IMDB Sign in Page")),
      body: Center(
          child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //buraya bi resim gelecek
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "E-mail",
                    hintText: "E-mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)))),
                onSaved: (deger) {
                  _email = deger!;
                },
                validator: (deger) {
                  //burasi duzenlenecek
                  if (deger!.length < 8) {
                    return "Girilen E-mail 8 Karakterden kucuk olamaz.";
                  } else
                    return null;
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)))),
                onSaved: (deger) {
                  _password = deger!;
                  // debugPrint(_password);
                },
                validator: (deger) {
                  if (deger!.length < 8) {
                    return "Password 8 karakterden kucuk olamaz";
                  } else
                    return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 50, 0),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/RegisterPage"),
                    child: Text(
                      "Kayıt Ol",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text(
                    "Şifreni mi unuttun ?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  bool _validate = _formKey.currentState!.validate();
                  if (_validate) {
                    _formKey.currentState!.save();
                  }
                  goHomePage(context);

                  //buraya hata mesajı goruntulenecek.
                },
                child: Container(
                    alignment: Alignment.center,
                    width: 150,
                    height: 25,
                    child: Text(
                      "Giris Yap",
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    )))
          ],
        ),
      )),
    );
  }

  void goHomePage(BuildContext context) async {
    List<Movie> watchList = [];
    List<Movie> userWatchList = [];
    List<Movie> allMovies = [];
    List<String> movieNameListString = [];
    List<String> movieWatchListString = [];

    FirebaseAndFire.loginWithEmailAndPassword(_email, _password);
    var userMap = await FirebaseAndFire.firestore.doc("users/" + _email).get();
    var movieList = userMap.data()!["movienamelist"];
    for (int i = 0; i < userMap.data()!["movielistCounter"]; i++) {
      var movie = movieList[i];
      movieNameListString.add(movie);

      var movieMap =
          await FirebaseAndFire.firestore.doc("movies/" + movie).get();

      watchList.add(Movie(
          movieName: movieMap.data()!["movieName"].toString(),
          movieRate: movieMap.data()!["movieRate"],
          movieDescription: movieMap.data()!["movieDescription"].toString(),
          movieDirector: movieMap.data()!["movieDirector"].toString(),
          movieStars: movieMap.data()!["movieStars"].toString(),
          movieSmallImageURL: movieMap.data()!["movieImageUrl"].toString()));
    }

    var movieWatchList = userMap.data()!["moviewatchlist"];
    for (int i = 0; i < userMap.data()!["watchlistCounter"]; i++) {
      var movie = movieWatchList[i];
      movieWatchListString.add(movie);
      var movieMap =
          await FirebaseAndFire.firestore.doc("movies/" + movie).get();

      userWatchList.add(Movie(
          movieName: movieMap.data()!["movieName"].toString(),
          movieRate: movieMap.data()!["movieRate"],
          movieDescription: movieMap.data()!["movieDescription"].toString(),
          movieDirector: movieMap.data()!["movieDirector"].toString(),
          movieStars: movieMap.data()!["movieStars"].toString(),
          movieSmallImageURL: movieMap.data()!["movieImageUrl"].toString()));
    }

    var movieDoc =
        await FirebaseAndFire.firestore.collection("movies").limit(25).get();

    for (var eleman in movieDoc.docs) {
      allMovies.add(Movie(
          movieName: eleman["movieName"],
          movieRate: eleman["movieRate"],
          movieDescription: eleman["movieDescription"],
          movieDirector: eleman["movieDirector"],
          movieStars: eleman["movieStars"],
          movieSmallImageURL: eleman["movieImageUrl"]));
    }

    var suankiuser = User(userMap.data()!["username"].toString(),
        userMap.data()!["password"].toString(),
        e_mail: userMap.data()!["email"].toString(),
        userMovieList: watchList,
        userWatchList: userWatchList,
        userMovieListString: movieNameListString,
        userWatchListString: movieWatchListString);
    Navigator.pushReplacementNamed(context, "/HomePage",
        arguments: [suankiuser, allMovies]);
  }
}
