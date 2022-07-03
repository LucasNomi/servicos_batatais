import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:servicos_batatais/routes/wrapper.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: ((context, child) => ResponsiveWrapper.builder(child,
              defaultScale: true,
              breakpoints: const [
                ResponsiveBreakpoint.resize(480, name: 'MOBILE'),
                ResponsiveBreakpoint.autoScale(760, name: 'TABLET'),
              ])),
      home: const Wrapper(),
    );
  }
}
