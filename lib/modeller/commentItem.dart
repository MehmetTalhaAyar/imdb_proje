import 'package:flutter/material.dart';
import 'package:imdb_proje/Classes/commentClass.dart';

import '../Classes/userClass.dart';

class CommentItem extends StatefulWidget {
  User suankiUser;
  Comment comment;
  CommentItem({Key? key, required this.suankiUser, required this.comment})
      : super(key: key);

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
              child: ListTile(
                  title: Text(widget.comment.username),
                  subtitle: Text(widget.comment.comment)),
              width: 300),
          SizedBox(
            width: 50,
          ),
          Container(
            child: Row(children: [
              Text(widget.comment.likeCount.toString()),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: (() {
                  setState(() {
                    if (!widget.comment.userWhoLikedTheComment
                        .contains(widget.suankiUser.getName)) {
                      widget.comment.likeCount++;
                      widget.comment.userWhoLikedTheComment
                          .add(widget.suankiUser.getName);
                    } else {
                      widget.comment.likeCount--;
                      widget.comment.userWhoLikedTheComment
                          .remove(widget.suankiUser.getName);
                    }
                  });
                }),
                child: Icon(
                  Icons.heart_broken,
                  color: Colors.red,
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
