import "dart:math";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Path coords(double w, double h, Path points) {
  final n = min(w, h) / 240;
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
class Poly extends StatefulWidget {
  final List<Offset> points;
  final Color clr;
  const Poly({super.key, required this.points, required this.clr});

  @override
  State<Poly> createState() => _PolyState();
}

class _PolyState extends State<Poly> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
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
          painter: PolyPainter(_controller.value, widget.points, widget.clr),
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

class PolyPainter extends CustomPainter {
  final double anim;
  final List<Offset> points;
  final Color clr;

  PolyPainter(this.anim, this.points, this.clr);

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
    return true;
  }
}

// #############
// ### Arrow ###
// #############
class Arrow extends StatefulWidget {
  final Offset p1;
  final Offset p2;
  final Color clr;
  const Arrow({super.key, required this.p1, required this.p2, required this.clr});

  @override
  State<Arrow> createState() => _ArrowState();
}

class _ArrowState extends State<Arrow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
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
          painter: ArrowPainter(_controller.value, widget.p1, widget.p2, widget.clr),
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

class ArrowPainter extends CustomPainter {
  final double anim;
  final Offset p1;
  final Offset p2;
  final Color clr;

  ArrowPainter(this.anim, this.p1, this.p2, this.clr);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final paint = Paint()
    ..color = clr
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

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
      //0, 0, 0, 1,
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

// ###########
// ### Arc ###
// ###########
class Arc extends StatefulWidget {
  final Offset c;
  final double r;
  final double a1;
  final double a2;
  final Color clr;

  const Arc({
    super.key,
    required this.c,
    required this.r,
    required this.a1,
    required this.a2,
    required this.clr
  });

  @override
  State<Arc> createState() => _ArcState();
}

class _ArcState extends State<Arc> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
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
          painter: ArcPainter(
            _controller.value,
            widget.c,
            widget.r,
            widget.a1,
            widget.a2,
            widget.clr
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

class ArcPainter extends CustomPainter {
  final double anim;
  final Offset c;
  final double r;
  final double a1;
  final double a2;
  final Color clr;

  ArcPainter(
    this.anim,
    this.c,
    this.r,
    this.a1,
    this.a2,
    this.clr
  );

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final paint = Paint()
    ..color = clr
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

    final d = r * min(size.width, size.height) / 120;
    final arcRect = Rect.fromCenter(center: Offset(size.width/2, size.height/2), width: d, height: d);
    final s = -a1*anim;
    final f = -(a2-a1)*anim;
    canvas.drawArc(arcRect, s, f, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
