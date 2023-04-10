class User {
  final String name;
  final String bio;
  final String email;
  final String dob;
  final String profileUrl;
  final String uid;
  final List<String> posts;
  final List<String> following;
  final List<String> followers;
  final List<String> chatroom;

  User({
    required this.name,
    required this.bio,
    required this.email,
    required this.dob,
    required this.profileUrl,
    required this.posts,
    required this.uid,
    required this.followers,
    required this.following,
    required this.chatroom,
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      bio: json['bio'],
      email: json['email'],
      dob: json['dob'],
      profileUrl: json['profile_pic'],
      posts: json['posts'].cast<String>(),
      uid: json['uid'],
      followers: json['followers'].cast<String>(),
      following: json['following'].cast<String>(),
      chatroom: json['chatroom'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bio': bio,
      'email': email,
      'dob': dob,
      'profile_pic': profileUrl,
      'posts': posts,
      'uid': uid,
      'followers': followers,
      'following': following,
      'chatroom': chatroom
    };
  }

  static User initialize() {
    return User(
      name: '',
      bio: '',
      email: '',
      dob: '',
      profileUrl: '',
      posts: [],
      uid: '',
      followers: [],
      following: [],
      chatroom: [],
    );
  }
}
