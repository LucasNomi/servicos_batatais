import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/login_screen.dart';
import '../screens/new_job_screen.dart';
import '../services/user_service.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../utils/colors.dart';
import '../widgets/ink_well_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  logoutUser() async {
    await AuthService().signOut();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  newJobScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NewJobScreen()));
  }

  @override
  Widget build(BuildContext context) {
    //* get user data
    MyUser user = Provider.of<UserService>(context).getUser;
    return SafeArea(
      child: Column(
        children: [
          //* user info [pfp, username]
          Container(
            decoration:
                const BoxDecoration(color: mobileHighlightBackgroundColor),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 66.0,
                    backgroundImage: NetworkImage(user.imageUrl),
                  ),
                  Text(
                    user.username,
                    style: const TextStyle(fontSize: 26.0),
                  ),
                ],
              ),
            ),
          ),
          //* Button new job
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
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
          //* button job history
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: InkWellButton(
              function: () {},
              children: const [
                Icon(Icons.history),
                Text(
                  ' Historico de Serviços',
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
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
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
    );
  }
}
