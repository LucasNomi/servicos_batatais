import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/job_card.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        //* Stream de elementos proveniente do banco de dados dos serviços
        //* cadastrados pelos usuários
        stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
        builder: ((context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //* Os serviços cadastrados são inseridos na tela em forma de lista,
          //* contendo as informações do serviço e o uid do usuário que cadastrou
          //* o serviço
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => JobCard(
              snap: snapshot.data!.docs[index].data(),
              uid: FirebaseAuth.instance.currentUser!.uid,
            ),
          );
        }),
      ),
    );
  }
}
