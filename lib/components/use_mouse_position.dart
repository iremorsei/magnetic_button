import 'package:flutter/material.dart';

class MousePositionResult {
  late final double? mouseX;
  late final double? mouseY;

  MousePositionResult({this.mouseX, this.mouseY});

  void updateMousePosition(PointerEvent event) {
    mouseX = event.position.dx;
    mouseY = event.position.dy;
  }
}

MousePositionResult useMousePosition() {
  final mouseX = ValueNotifier<double?>(null);
  final mouseY = ValueNotifier<double?>(null);

  final result = MousePositionResult(
    mouseX: mouseX.value,
    mouseY: mouseY.value,
  );

  return result;
}

class MousePositionExample extends StatelessWidget {
  final Widget child;

  const MousePositionExample({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mousePositionResult = useMousePosition();

    return MouseRegion(
      onEnter: (event) => mousePositionResult.updateMousePosition(event),
      onExit: (event) => mousePositionResult.updateMousePosition(event),
      onHover: (event) => mousePositionResult.updateMousePosition(event),
      child: child,
    );
  }
}

class MousePositionWidget extends StatefulWidget {
  final Widget child;

  const MousePositionWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  State<MousePositionWidget> createState() => _MousePositionWidgetState();
}

class _MousePositionWidgetState extends State<MousePositionWidget> {
  @override
  Widget build(BuildContext context) {
    Offset _lastPointerMoveLocation;
    return Listener(
      onPointerMove: (PointerMoveEvent event) {
        setState(() {
          _lastPointerMoveLocation = event.position;
        });
      },
      child: widget.child,
    );
  }
}
