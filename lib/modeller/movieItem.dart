import 'package:flutter/material.dart';

import '../Classes/movieClass.dart';

class movieItem extends StatelessWidget {
  Movie myMovie;
  Function() myfunc;

  movieItem({required this.myMovie, required this.myfunc, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade300,
      child: ListTile(
        title: Row(
          children: [
            Container(
              child: Text(
                myMovie.movieName,
                style: TextStyle(fontSize: 16),
              ),
              width: 200,
            ),
            SizedBox(
              width: 50,
            ),
            GestureDetector(
              onTap: myfunc,
              child: Icon(
                Icons.add_to_photos_outlined,
                color: Colors.blue,
              ),
            )
          ],
        ),
        subtitle: Text(myMovie.movieRate.toString()),
        leading: Image.network(
          myMovie.movieSmallImageURL,
        ),
      ),
    );
  }
}
