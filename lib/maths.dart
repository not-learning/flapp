import 'package:flapp/utils.dart';
import 'package:flutter/material.dart';

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
              onPressed: () => Navigator.pushNamed(context, 'algebra01'),
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
