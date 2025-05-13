import 'package:flutter/material.dart';
import 'utils.dart';

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
