import 'package:cloud_firestore/cloud_firestore.dart';

class Jobs {
  final String uid;
  final String username;
  final String imageUrl;
  final String uuid;
  final String jobName;
  final String jobCountryCode;
  final String jobFilter;
  final String phoneNumber;

  const Jobs({
    required this.uid,
    required this.username,
    required this.imageUrl,
    required this.uuid,
    required this.jobName,
    required this.jobCountryCode,
    required this.jobFilter,
    required this.phoneNumber,
  });

  static Jobs fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Jobs(
      uid: snapshot['uid'],
      username: snapshot['username'],
      imageUrl: snapshot['imageUrl'],
      uuid: snapshot['uuid'],
      jobName: snapshot['jobName'],
      jobCountryCode: snapshot['jobCountryCode'],
      jobFilter: snapshot['jobFilter'],
      phoneNumber: snapshot['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'imageUrl': imageUrl,
        'uuid': uuid,
        'jobName': jobName,
        'jobCountryCode': jobCountryCode,
        'jobFilter': jobFilter,
        'phoneNumber': phoneNumber,
      };
}
