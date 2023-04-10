import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String caption;
  final DateTime createdOn;
  final String ownerUid;
  final String uid;
  final String url;
  final String username;
  final String profileUrl;
   final List<String> likes;
  final List<String> comments;

  Post({
    required this.likes,
    required this.comments,
    required this.caption,
    required this.createdOn,
    required this.uid,
    required this.ownerUid,
    required this.url,
    required this.username,
    required this.profileUrl,
  });

  static Post fromJson(Map<String, dynamic> json) {
    return Post(
      caption: json['caption'],
      createdOn: (json['created-on'] as Timestamp).toDate(),
      uid: json['uid'],
      ownerUid: json['owner-uid'],
      url: json['url'],
      username: json['username'],
      profileUrl: json['userProfile'],
       likes: json['Likes'].cast<String>(),
      comments: json['comments'].cast<String>(),
    );
  }

  static Post initialize() {
    return Post(
      caption: "",
      createdOn: DateTime.now(),
      uid: "",
      ownerUid: "",
      url: "",
      username: "",
      profileUrl: "",
      likes: [],
      comments: [],
    );
  }
}
