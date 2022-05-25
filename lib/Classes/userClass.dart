import 'movieClass.dart';

class User {
  String _name;
  String _password;
  String e_mail;
  List<Movie>? userMovieList;
  List<Movie>? userWatchList;
  List<String>? userMovieListString = [];
  List<String>? userWatchListString =[];

  User(this._name, this._password,
      {this.e_mail = "", this.userMovieList, this.userWatchList,this.userMovieListString,this.userWatchListString});

  get getPassword => _password;
  get getName => _name;
}
