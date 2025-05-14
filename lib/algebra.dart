import 'package:flapp/shapes.dart';
import 'package:flutter/material.dart';
import 'utils.dart';

class AlgebraPage extends StatelessWidget {
  const AlgebraPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(child:
              Stack(
                children: [
                  TextAnim(
                    text: 'x + 3 = 5',
                    startP1: Offset(-100, -100),
                    startP2: Offset(120, -120),
                    finishP1: Offset(0, 0),
                    finishP2: Offset(120, -100),
                    startClr: null,
                    finishClr: Colors.white,
                    dur: 1,
                  ),
                ],
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
