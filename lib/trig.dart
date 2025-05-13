import 'package:flutter/material.dart';
import 'utils.dart';
import 'shapes.dart';

class TrigPage extends StatelessWidget {
  const TrigPage({super.key});
  final cl = 113.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            Expanded(
              child: Stack(
                children: [
                  /*Poly(points: [
                  Offset(-10, 0),
                  Offset(10, 0),
                ],
                clr: Colors.blue,
                ),
                  Poly(points: [
                  Offset(0, -10),
                  Offset(0, 10),
                ],
                clr: Colors.blue,
                ),*/
                Arc(
                  c: Offset(0, 0),
                  r: 100,
                  a1: 0.2,
                  a2: -6.48,
                  clr: Colors.green,
                ),
                Arrow(p1: Offset(0, -cl), p2: Offset(0, cl), clr: Colors.blue),
                Arrow(p1: Offset(-cl, 0), p2: Offset(cl, 0), clr: Colors.blue),
                ]
              ),
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
