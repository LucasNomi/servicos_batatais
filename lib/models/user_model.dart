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

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'username': username,
        'imageUrl': imageUrl,
      };
}
