class Comment {
  String username;
  String comment;
  DateTime time = DateTime(2022);
  int likeCount = 0;
  List<String> userWhoLikedTheComment = [];
  Comment(this.username, this.comment);
}
