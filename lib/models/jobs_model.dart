import 'package:cloud_firestore/cloud_firestore.dart';

class Jobs {
  final String uid;
  final String username;
  final String imageUrl;
  final String uuid;
  final String jobName;
  final String jobDesc;
  final String phoneNumber;

  const Jobs(
      {required this.uid,
      required this.username,
      required this.imageUrl,
      required this.uuid,
      required this.jobName,
      required this.jobDesc,
      required this.phoneNumber});

  static Jobs fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Jobs(
      uid: snapshot['uid'],
      username: snapshot['username'],
      imageUrl: snapshot['imageUrl'],
      uuid: snapshot['uuid'],
      jobName: snapshot['jobName'],
      jobDesc: snapshot['jobDesc'],
      phoneNumber: snapshot['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'imageUrl': imageUrl,
        'uuid': uuid,
        'jobName': jobName,
        'jobDesc': jobDesc,
        'phoneNumber': phoneNumber,
      };
}
