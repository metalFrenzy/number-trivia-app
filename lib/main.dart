import 'package:flutter/material.dart';
import 'injection_container.dart' as di;

import 'features/number_trivia/presentation/screen/number_trivia_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Color.fromARGB(255, 195, 144, 211),
          secondary: Color.fromARGB(255, 135, 142, 220),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              displayLarge: const TextStyle(
                fontFamily: 'Raleway',
                fontSize: 24,
                color: Color.fromARGB(255, 241, 241, 241),
              ),
              displayMedium: const TextStyle(
                fontFamily: 'Raleway',
                fontSize: 20,
                color: Color.fromARGB(255, 43, 42, 43),
              ),
              displaySmall: const TextStyle(
                fontFamily: 'Raleway',
                fontSize: 18,
                color: Color.fromARGB(255, 241, 241, 241),
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: NumberTriviaScreen(),
    );
  }
}
