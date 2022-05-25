import 'dart:ffi';

import 'package:imdb_proje/Classes/commentClass.dart';

class Movie {
  String movieName;
  double movieRate;
  String movieDescription;
  String movieDirector;
  late String _movieImage;
  String movieStars;
  String movieSmallImageURL;
  List<Comment> movieCommentList = [];

  Movie(
      {required this.movieName,
      required this.movieRate,
      required this.movieDescription,
      required this.movieDirector,
      required this.movieStars,
      required this.movieSmallImageURL}) {
    this._movieImage = this.movieName +
        "_Image" +
        ".jpg".replaceAll(":", "_").replaceAll("è", "e");
  }
  get getMovieImage => this._movieImage;
}
