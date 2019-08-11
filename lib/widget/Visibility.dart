import 'package:flutter/material.dart';

class Visibility extends StatefulWidget {

  static const int VISIBLE = 3;
  static const int INVISIBLE = 2;
  static const int OFFSCREEN = 1;
  static const int GONE = 0;

  final Widget child;
  final Widget removeChild;
  final int visibility;

  Visibility({this.child, this.removeChild, this.visibility});

  @override
  _VisibilityState createState() => _VisibilityState();
}

class _VisibilityState extends State<Visibility> {
  @override
  Widget build(BuildContext context) {
    if (widget.visibility == Visibility.VISIBLE) {
      return widget.child;
    } else if (widget.visibility == Visibility.INVISIBLE) {
      return new IgnorePointer(
          ignoring: true, child: new Opacity(opacity: 0.0, child: widget.child));
    } else if (widget.visibility == Visibility.OFFSCREEN) {
      return new Offstage(offstage: true, child: widget.child);
    } else {
      return widget.removeChild;
    }
  }
}
