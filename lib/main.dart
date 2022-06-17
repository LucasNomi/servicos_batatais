import 'package:flutter/material.dart';
import 'package:servicos_batatais/routes/homepage.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
          ResponsiveBreakpoint.resize(350, name: MOBILE),
          ResponsiveBreakpoint.autoScale(600, name: TABLET),
          ResponsiveBreakpoint.resize(800, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(1000, name: 'XL')
        ],
      ),
      initialRoute: '/',
      home: const HomePage(),
    );
  }
}
