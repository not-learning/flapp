import 'package:flutter/material.dart';
import 'utils.dart';
import 'algebra.dart';
import 'power.dart';
import 'trig.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  //var selectedPage = 'maths';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ## Routing
      initialRoute: 'trig',
      routes: {
        'maths': (context) => MathsPage(),
        'algebra': (context) => AlgebraPage(),
        'power': (context) => PowerPage(),
        'trig': (context) => TrigPage(),
      },

      // ## Theme
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.lightBlueAccent,
        ),
      ),
      //themeMode: ThemeMode.light,
      themeMode: ThemeMode.system,

      // ## Content
      home: Scaffold(
        body: MathsPage(),
      ),
    );
  }
}

class MathsPage extends StatelessWidget {
  const MathsPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, 'algebra'),
              child: TextL(str: 'Алгебра'),
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, 'power'),
              child: TextL(str: 'Степени'),
            ),
            //SizedBox(height: 10),
            TextButton(onPressed: () => Navigator.pushNamed(context, 'trig'),
            child: TextL(str: 'Тригонометрия')),
          ],
        ),
      ),
    );
  }
}
