import "dart:math";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _scale = 130;

Path coords(double w, double h, Path points) {
  final n = min(w, h) / (_scale*2);
  return points.transform(Float64List.fromList([
      n, 0, 0, 0,
      0, -n, 0, 0,
      0, 0, 1, 0,
      w/2, h/2, 0, 1,
    ]));
}

// ############
// ### Poly ###
// ############
class Poly extends StatelessWidget {
  final List<Offset> points;
  final Color clr;

  const Poly({
    super.key,
    required this.points,
    required this.clr
  });
  
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height,
      ),
      painter: PolyPainter(points, clr),
    );
  }
}

class PolyPainter extends CustomPainter {
  final List<Offset> points;
  final Color clr;

  const PolyPainter(this.points, this.clr);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final paint = Paint()
    ..color = clr
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

    final path = Path();
    path.addPolygon(points, false);
    canvas.drawPath(coords(size.width, size.height, path), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// #################
// ### ArrowAnim ###
// #################
class ArrowAnim extends StatefulWidget {
  final Offset startP1;
  final Offset startP2;
  final Offset finishP1;
  final Offset finishP2;
  final Color? startClr;
  final Color? finishClr;
  final double dur;

  const ArrowAnim({
    super.key,
    required this.startP1,
    required this.startP2,
    required this.finishP1,
    required this.finishP2,
    required this.startClr,
    required this.finishClr,
    required this.dur,
  });

  @override
  State<ArrowAnim> createState() => _ArrowAnimState();
}

class _ArrowAnimState extends State<ArrowAnim> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.dur*1000).toInt()),
    )..forward();
    //repeat(reverse: true);
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
          painter: ArrowAnimPainter(
            _controller.value,
            widget.startP1,
            widget.startP2,
            widget.finishP1,
            widget.finishP2,
            widget.startClr,
            widget.finishClr,
          ),
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

class ArrowAnimPainter extends CustomPainter {
  final double anim;
  final Offset startP1;
  final Offset startP2;
  final Offset finishP1;
  final Offset finishP2;
  final Color? startClr;
  final Color? finishClr;
  Color clr = Colors.transparent;
  Color? clrN = Colors.transparent;

  ArrowAnimPainter(
    this.anim,
    this.startP1,
    this.startP2,
    this.finishP1,
    this.finishP2,
    this.startClr,
    this.finishClr,
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    if (startClr != finishClr) {
      clrN = Color.lerp(startClr, finishClr, anim);
      if (clrN != null) { clr = clrN!; }
    } else {
      clr = startClr!;
    }

    final paint = Paint()
    ..color = clr
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

    final p1 = (finishP1-startP1)*anim + startP1;
    final p2 = (finishP2-startP2)*anim + startP2;
    final tx = 10.0;
    final ty = 3.0;
    final d = p2-p1;
    final l = d.distance;
    final c = d.dx/l;
    final s = d.dy/l;

    final ar = Path();
    ar
     ..lineTo(l, 0)
     ..relativeLineTo(-tx, -ty)
     ..moveTo(l, 0)
     ..relativeLineTo(-tx, ty);

    final arr = ar.transform(Float64List.fromList([
      c, s, 0, 0,
      -s, c, 0, 0,
      0, 0, 1, 0,
      p1.dx, p1.dy, 0, 1,
    ]));

    final arrow = coords(size.width, size.height, arr);
    canvas.drawPath(arrow, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// ###############
// ### ArcAnim ###
// ###############
class ArcAnim extends StatefulWidget {
  final Offset startC;
  final Offset finishC;
  final double startR;
  final double finishR;
  final double startA1;
  final double startA2;
  final double finishA1;
  final double finishA2;
  final Color? startClr;
  final Color? finishClr;
  final bool fill;
  final double dur;

  const ArcAnim({
    super.key,
    required this.startC,
    required this.finishC,
    required this.startR,
    required this.finishR,
    required this.startA1,
    required this.startA2,
    required this.finishA1,
    required this.finishA2,
    required this.startClr,
    required this.finishClr,
    required this.fill,
    required this.dur,
  });

  @override
  State<ArcAnim> createState() => _ArcAnimState();
}

class _ArcAnimState extends State<ArcAnim> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.dur*1000).toInt()),
    )..forward();
    //forward();
    //repeat(reverse: true);
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
          painter: ArcAnimPainter(
            _controller.value,
            widget.startC,
            widget.finishC,
            widget.startR,
            widget.finishR,
            widget.startA1,
            widget.startA2,
            widget.finishA1,
            widget.finishA2,
            widget.startClr,
            widget.finishClr,
            widget.fill,
          ),
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

class ArcAnimPainter extends CustomPainter {
  final double anim;
  final Offset startC;
  final Offset finishC;
  final double startR;
  final double finishR;
  final double startA1;
  final double startA2;
  final double finishA1;
  final double finishA2;
  final Color? startClr;
  final Color? finishClr;
  final bool fill;
  Color clr = Colors.transparent;
  Color? clrN = Colors.transparent;

  ArcAnimPainter(
    this.anim,
    this.startC,
    this.finishC,
    this.startR,
    this.finishR,
    this.startA1,
    this.startA2,
    this.finishA1,
    this.finishA2,
    this.startClr,
    this.finishClr,
    this.fill,
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    if (startClr != finishClr) {
      clrN = Color.lerp(startClr, finishClr, anim);
      if (clrN != null) { clr = clrN!; }
    } else {
      clr = startClr!;
    }

    final paint = Paint()
    ..color = clr
    ..strokeWidth = 1.0;
    if (fill) {
      paint.style = PaintingStyle.fill;
    } else {
      paint.style = PaintingStyle.stroke;
    }

    final r = (finishR-startR)*anim + startR;
    final d = r * min(size.width, size.height) / _scale;
    final c = ((finishC-startC)*anim + startC) + Offset(size.width/2, size.height/2);
    final arcRect = Rect.fromCenter(center: c, width: d, height: d);
    final sa = (finishA1-startA1)*anim + startA1;
    final fa = (finishA2-startA2)*anim + startA2;
    canvas.drawArc(arcRect, sa, fa, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// ##############
// ### PtAnim ###
// ##############
class PtAnim extends ArcAnim {

  const PtAnim({
    super.key,
    required super.startC,
    required super.finishC,
    required super.startClr,
    required super.finishClr,
    required super.dur,
  }) : super(startR: 1, finishR: 1, startA1: 0, finishA1: 0, startA2: 2*pi, finishA2: 2*pi, fill: true);
}

// ################
// ### TextAnim ###
// ################
class TextAnim extends StatefulWidget {
  final String text;
  final double? fontSize;
  final Offset startP1;
  final Offset startP2;
  final Offset finishP1;
  final Offset finishP2;
  final Color? startClr;
  final Color? finishClr;
  final double dur;

  const TextAnim({
    super.key,
    required this.text,
    required this.fontSize,
    required this.startP1,
    required this.startP2,
    required this.finishP1,
    required this.finishP2,
    required this.startClr,
    required this.finishClr,
    required this.dur,
  });

  @override
  State<TextAnim> createState() => _TextAnimState();
}

class _TextAnimState extends State<TextAnim> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: (widget.dur*1000).toInt()),
    )..forward();
    //repeat(reverse: true);
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
          painter: TextAnimPainter(
            _controller.value,
            widget.text,
            widget.fontSize,
            widget.startP1,
            widget.startP2,
            widget.finishP1,
            widget.finishP2,
            widget.startClr,
            widget.finishClr,
          ),
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

class TextAnimPainter extends CustomPainter {
  final double anim;
  final String text;
  final double? fontSize;
  final Offset startP1;
  final Offset startP2;
  final Offset finishP1;
  final Offset finishP2;
  final Color? startClr;
  final Color? finishClr;
  Color clr = Colors.transparent;
  Color? clrN = Colors.transparent;


  TextAnimPainter(
    this.anim,
    this.text,
    this.fontSize,
    this.startP1,
    this.startP2,
    this.finishP1,
    this.finishP2,
    this.startClr,
    this.finishClr,
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    if (startClr != finishClr) {
      clrN = Color.lerp(startClr, finishClr, anim);
      if (clrN != null) { clr = clrN!; }
    } else {
      clr = startClr!;
    }
    
    final s1 = Offset(startP1.dx, -startP1.dy);
    final s2 = Offset(startP2.dx, -startP2.dy);
    final f1 = Offset(finishP1.dx, -finishP1.dy);
    final f2 = Offset(finishP2.dx, -finishP2.dy);
    final p1 = (f1-s1)*anim + s1 + Offset(size.width/2, size.height/2);
    final p2 = (f2-s2)*anim + s2 + Offset(size.width/2, size.height/2);
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: clr,
          fontSize: fontSize,
        ),
      ),
      textDirection: TextDirection.ltr,
    )
    ..layout(maxWidth: p2.dx-p1.dx);
    textPainter.paint(canvas, p1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}