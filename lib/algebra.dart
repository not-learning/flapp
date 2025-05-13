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
