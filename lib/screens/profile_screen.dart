import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:servicos_batatais/utils/utils.dart';

import '../screens/login_screen.dart';
import '../screens/new_job_screen.dart';
import '../services/auth_service.dart';
import '../utils/colors.dart';
import '../widgets/ink_well_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var userData = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();

      userData = userSnap.data()!;

      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  logoutUser() async {
    await AuthService().signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  newJobScreen() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const NewJobScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //* user info [pfp, username]
                  Container(
                    decoration:
                        const BoxDecoration(color: highlightBackgroundColor),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 66.0,
                            backgroundImage: NetworkImage(userData['imageUrl']),
                          ),
                          Text(
                            userData['username'],
                            style: const TextStyle(fontSize: 26.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //* Button new job
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 15.0),
                    child: InkWellButton(
                      function: newJobScreen,
                      children: const [
                        Icon(Icons.add),
                        Text(
                          ' Novo Serviço',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //* button logout
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 15.0),
                    child: InkWellButton(
                      function: logoutUser,
                      children: const [
                        Icon(Icons.logout),
                        Text(
                          ' Sair do app',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
