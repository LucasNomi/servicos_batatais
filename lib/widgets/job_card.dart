import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/job_service.dart';
import '../widgets/ink_well_button.dart';
import '../utils/colors.dart';

class JobCard extends StatelessWidget {
  final snap;
  final uid;
  const JobCard({Key? key, required this.snap, required this.uid})
      : super(key: key);

  openWhatsapp() async {
    String phoneNumber = snap['jobCountryCode'] + snap['phoneNumber'];
    Uri whatsappUrl =
        Uri.parse('https://api.whatsapp.com/send?phone=$phoneNumber');

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    }
  }

  deleteJob(String uuid, BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Deletar serviço'),
            children: [
              SimpleDialogOption(
                child: const Text('Não'),
                onPressed: () => Navigator.pop(context),
              ),
              SimpleDialogOption(
                child: const Text('Sim'),
                onPressed: () async {
                  Navigator.pop(context);
                  await JobService().deleteJob(uuid);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: highlightBackgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Divider(
              thickness: 2,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(snap['imageUrl']),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  snap['username'],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  snap['jobName'],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  width: double.infinity,
                  child: snap['uid'] == uid
                      ? InkWellButton(
                          function: () => deleteJob(snap['uuid'], context),
                          children: const [
                            Text("Deletar"),
                          ],
                        )
                      : InkWellButton(
                          function: openWhatsapp,
                          children: const [
                            Text("Abrir Whatsapp"),
                          ],
                        ),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            )
          ],
        ),
      ),
    );
  }
}
