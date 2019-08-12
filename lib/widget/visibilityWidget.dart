import 'package:flutter/material.dart';

class VisibilityWidget extends StatefulWidget {

  static const int VISIBLE = 3;
  static const int INVISIBLE = 2;
  static const int OFFSCREEN = 1;
  static const int GONE = 0;

  final Widget child;
  final Widget removeChild;
  final int visibility;

  VisibilityWidget({this.child, this.removeChild, this.visibility});

  @override
  _VisibilityWidgetState createState() => _VisibilityWidgetState();
}

class _VisibilityWidgetState extends State<VisibilityWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.visibility == VisibilityWidget.VISIBLE) {
      return widget.child;
    } else if (widget.visibility == VisibilityWidget.INVISIBLE) {
      return new IgnorePointer(
          ignoring: true, child: new Opacity(opacity: 0.0, child: widget.child));
    } else if (widget.visibility == VisibilityWidget.OFFSCREEN) {
      return new Offstage(offstage: true, child: widget.child);
    } else {
      return widget.removeChild;
    }
  }
}
