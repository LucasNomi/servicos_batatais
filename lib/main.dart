import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:servicos_batatais/routes/wrapper.dart';

void main() => runApp(const MainPage());

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.autoScale(780, name: TABLET),
        ],
      ),
      home: const Wrapper(),
    );
  }
}
