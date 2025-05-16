import 'package:flutter/widgets.dart';
import 'maths.dart';
import 'algebra.dart';
import 'power.dart';
import 'trig.dart';

var march = <String, Widget Function(BuildContext)>{
  'maths': (context) => MathsPage(),

  'algebra01': (context) => Algebra01(),
  'algebra02': (context) => Algebra02(),

  'power': (context) => PowerPage(),

  'trig': (context) => TrigPage(),
};
