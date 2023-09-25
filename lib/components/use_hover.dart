import 'package:flutter/material.dart';

class HoverWidget extends StatefulWidget {
  final Widget child;
  final bool isHovering;
  const HoverWidget({super.key, required this.child, required this.isHovering});

  @override
  State<HoverWidget> createState() => _HoverWidgetState();
}

class _HoverWidgetState extends State<HoverWidget> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onTapDown: (TapDownDetails details) {
        setState(() {
          _isHovering = true;
        });
      },
      onTapCancel: () {
        setState(() {
          _isHovering = false;
        });
      },
      child: widget.child,
    );
  }
}
