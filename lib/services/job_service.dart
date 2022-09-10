import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../models/jobs_model.dart';

class JobService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//* upload job to cloud firestore
  uploadJob(
    String uid,
    String username,
    String imageUrl,
    String jobName,
    String jobDesc,
    String jobCountryCode,
    String phoneNumber,
  ) {
    String res = 'Some error occurred';
    try {
      if (jobName.isNotEmpty || jobDesc.isNotEmpty || phoneNumber.isNotEmpty) {
        String uuid = const Uuid().v1();
        Jobs job = Jobs(
            uid: uid,
            username: username,
            imageUrl: imageUrl,
            uuid: uuid,
            jobName: jobName,
            jobDesc: jobDesc,
            jobCountryCode: jobCountryCode,
            phoneNumber: phoneNumber);

        _firestore.collection('jobs').doc(uuid).set(job.toJson());
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //* deleting job from cloud firestore
}
