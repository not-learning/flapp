import 'package:flutter/material.dart';
import 'utils.dart';

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

class AlgebraPage extends StatelessWidget {
  const AlgebraPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(child:
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(child:
                  TextL(str: 'y = ax + b'),
                ),
              ),
            ),

            TextS(str: 'I got Algebra!'),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'maths'),
                  child: TextL(str: 'B'),
                ),
                TextButton(onPressed: (){}, child: TextL(str: 'P')),
                TextButton(onPressed: (){}, child: TextL(str: 'F')),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class PowerPage extends StatelessWidget {
  const PowerPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(child:
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(child:
                  TextL(str: 'aaa'),
                ),
              ),
            ),

            TextS(str: 'I got the Power!'),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'maths'),
                  child: TextL(str: 'B'),
                ),
                TextButton(onPressed: (){}, child: TextL(str: 'P')),
                TextButton(onPressed: (){}, child: TextL(str: 'F')),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class TrigPage extends StatelessWidget {
  const TrigPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            Expanded(
              child: Line(),              
            ),

            TextS(str: 'I got the Trig!'),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, 'maths'),
                  child: TextL(str: 'B'),
                ),
                TextButton(onPressed: (){}, child: TextL(str: 'P')),
                TextButton(onPressed: (){}, child: TextL(str: 'F')),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class Line extends StatefulWidget {
  const Line({super.key});

  @override
  State<Line> createState() => _LineState();
}

class _LineState extends State<Line> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 333),
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          ),
          painter: LinePainter(_controller.value),
        );
      },
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class LinePainter extends CustomPainter {
  final double anim;

  LinePainter(this.anim);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

    final double x1 = 0;
    final double y1 = 0;
    final double x2 = size.width;
    final double y2 = size.height;
    final double x = x1 + (x2-x1)*anim;
    final double y = y1 + (y2-y1)*anim;
    final double a = x2 - (x2-x1)*anim;
    final double b = y2 - (y2-y1)*anim;

    canvas.drawLine(Offset(x1, y2), Offset(x, y), paint);
    canvas.drawLine(Offset(x2, y1), Offset(a, b), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}