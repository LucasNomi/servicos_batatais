import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/job_card.dart';
import '../utils/colors.dart';
import '../utils/filters.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String dropdownValue = filters.first;
  bool isShowResult = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          leading: const Icon(Icons.search),
          title: Form(
            child: DropdownButton(
              value: dropdownValue,
              isExpanded: true,
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                  isShowResult = true;
                });
              },
              items: filters.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
        body: isShowResult
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('jobs')
                    .where('jobFilter', isEqualTo: dropdownValue)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) {
                        return JobCard(
                            snap:
                                (snapshot.data! as dynamic).docs[index].data(),
                            uid: FirebaseAuth.instance.currentUser!.uid);
                      });
                })
            : const Center(child: Text('Faça sua pesquisa no dropdown acima')));
  }
}
