import 'package:flutter/material.dart';
import 'package:imdb_proje/Classes/commentClass.dart';
import 'package:imdb_proje/Classes/userClass.dart';
import 'package:imdb_proje/Functions/firebaseAndFire.dart';
import 'package:imdb_proje/modeller/commentItem.dart';

import '../Classes/movieClass.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;
  final User suankiUser;
  const MoviePage({Key? key, required this.movie, required this.suankiUser})
      : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  String _comment = "";
  var _fromKey = GlobalKey<FormState>();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //bu sayfaya storagekey tanımlaancak
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.grey.shade400,
          automaticallyImplyLeading: false,
          toolbarHeight: 200,
          //zaman kalırsa internetten veri goruntuleyecez.
          title: Image.network(widget.movie.movieSmallImageURL),
          bottom: PreferredSize(
            preferredSize: _myTabbar().preferredSize,
            child: ColoredBox(
              color: Colors.lightBlue.shade100, //burasi ayarlanacak
              child: _myTabbar(),
            ),
          ),
        ),
        body: Container(
          color: Colors.grey,
          child: TabBarView(
            children: [
              Text(
                widget.movie.movieDescription,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 330,
                    child: ListView.builder(
                      itemCount: widget.movie.movieCommentList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CommentItem(
                          comment: widget.movie.movieCommentList[index],
                          suankiUser: widget.suankiUser,
                        );
                      },
                    ),
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _fromKey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "";
                          }
                        },
                        onSaved: (value) {
                          _comment = value!;
                        },
                        decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                                child: Icon(Icons.send),
                                onTap: () {
                                  bool _validate =
                                      _fromKey.currentState!.validate();
                                  if (_validate) {
                                    _fromKey.currentState!.save();
                                    print(widget.movie.movieCommentList.length);
                                    setState(() {
                                      widget.movie.movieCommentList.add(Comment(
                                          widget.suankiUser.getName, _comment));
                                    });
                                    FirebaseAndFire.addCommentToDatabase(
                                        widget.movie.movieName,
                                        Comment(widget.suankiUser.getName,
                                            _comment));
                                  }
                                }),
                            hintText: "Enter Comment",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(24)))),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  // FirebaseAndFire.getAllComments(
  //                       widget.movie.movieName, widget.movie.movieCommentList);

  TabBar _myTabbar() {
    return TabBar(
      indicatorColor: Colors.teal,
      labelColor: Colors.green,
      unselectedLabelColor: Colors.black,
      labelStyle: TextStyle(fontSize: 16),
      tabs: [
        Tab(
          text: "Description",
        ),
        Tab(
          text: "Comments",
        ),
      ],
    );
  }
}
