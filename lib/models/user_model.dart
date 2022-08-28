import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String uid;
  final String email;
  final String username;
  final String imageUrl;

  const MyUser({
    required this.uid,
    required this.email,
    required this.username,
    required this.imageUrl,
  });

  static MyUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return MyUser(
      uid: snapshot['uid'],
      email: snapshot['email'],
      username: snapshot['username'],
      imageUrl: snapshot['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'username': username,
        'imageUrl': imageUrl,
      };
}
