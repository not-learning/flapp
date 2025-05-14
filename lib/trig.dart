import "dart:math";
import 'package:flutter/material.dart';
import 'utils.dart';
import 'shapes.dart';

class TrigPage extends StatelessWidget {
  const TrigPage({super.key});
  final cl = 120.0;
  final dur = 1.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            Expanded(
              child: Stack(
                children: [
                  ArcAnim(
                    startC: Offset(-50, -30),
                    finishC: Offset(0, 0),
                    startR: 0,
                    finishR: 100,
                    startA1: 2*pi,
                    finishA1: 2*pi,
                    startA2: 2*pi,
                    finishA2: 2*pi,
                    startClr: null,
                    finishClr: Colors.green,
                    fill: false,
                    dur: dur,
                  ),
                  ArrowAnim(
                    startP1: Offset(0, -cl),
                    startP2: Offset(0, cl),
                    finishP1: Offset(0, -cl),
                    finishP2: Offset(0, cl),
                    startClr: null,
                    finishClr: Colors.blue,
                    dur: dur,
                  ),
                  ArrowAnim(
                    startP1: Offset(-cl, 0),
                    startP2: Offset(cl,  0),
                    finishP1: Offset(-cl, 0),
                    finishP2: Offset(cl, 0),
                    startClr: null,
                    finishClr: Colors.blue,
                    dur: dur,
                  ),
                  PtAnim(
                    startC: Offset(-10, -50),
                    finishC: Offset(10, 0),
                    startClr: null,
                    finishClr: Colors.white,
                    dur: dur/2
                  )
                ]
              ),
            ),

            TextS(str: 'I got the Trig!'),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
