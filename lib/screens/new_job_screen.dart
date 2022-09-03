import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewJobScreen extends StatefulWidget {
  const NewJobScreen({Key? key}) : super(key: key);

  @override
  State<NewJobScreen> createState() => _NewJobScreenState();
}

class _NewJobScreenState extends State<NewJobScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('SALVE'),
    );
  }
}
