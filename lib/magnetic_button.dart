import 'package:flutter/material.dart';

import 'components/use_mouse_position.dart';
import 'components/utils.dart';

class Button extends StatefulWidget {
  final String href;
  final Widget child;

  const Button({
    Key? key,
    required this.href,
    required this.child,
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  final mousePositionResult = useMousePosition();
  double? mouseX;
  double? mouseY;
  final textRef = GlobalKey();
  final fillControls = AnimationController(
    vsync: AnimatedListState(),
    duration: const Duration(milliseconds: 550),
  );

  @override
  void initState() {
    super.initState();
    mouseX = mousePositionResult.mouseX as double?;
    mouseY = mousePositionResult.mouseY as double?;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          textRef.currentContext?.findRenderObject() as RenderBox;
      final rect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
      final distanceToTrigger = rect.width * 0.7;
      final distanceMouseButton = distance(
        mouseX! + WidgetsBinding.instance.window.physicalSize.width,
        mouseY! + WidgetsBinding.instance.window.physicalSize.height,
        rect.left + rect.width / 2,
        rect.top + rect.height / 2,
      );

      if (distanceMouseButton < distanceToTrigger) {
        final x = (mouseX! - (rect.left + rect.width / 2)) * 0.2;
        final y = (mouseY! - (rect.top + rect.height / 2)) * 0.2;

        textRef.currentContext!.findRenderObject()!.paintBounds
          ..addOversized(rect, x, y)
          ..offset(rect.left, rect.top)
          ..paintTransform = Matrix4.identity()
          ..addTranslation(x, y);
        fillControls.animateTo(1, curve: Curves.easeInOut);
      } else {
        fillControls.animateTo(0, curve: Curves.easeInOut);
      }
    });
  }

  void _onpress() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          textRef.currentContext?.findRenderObject() as RenderBox;
      final rect = renderBox.localToGlobal(Offset.zero) & renderBox.size;
      final distanceToTrigger = rect.width * 0.7;
      final distanceMouseButton = distance(
        mouseX! + WidgetsBinding.instance.window.physicalSize.width,
        mouseY! + WidgetsBinding.instance.window.physicalSize.height,
        rect.left + rect.width / 2,
        rect.top + rect.height / 2,
      );

      if (distanceMouseButton < distanceToTrigger) {
        final x = (mouseX! - (rect.left + rect.width / 2)) * 0.2;
        final y = (mouseY! - (rect.top + rect.height / 2)) * 0.2;

        textRef.currentContext!.findRenderObject()!.paintBounds
          ..addOversized(rect, x, y)
          ..offset(rect.left, rect.top)
          ..paintTransform = Matrix4.identity()
          ..addTranslation(x, y);
        fillControls.animateTo(1, curve: Curves.easeInOut);
      } else {
        fillControls.animateTo(0, curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => mousePositionResult.updateMousePosition(event),
      onExit: (event) => mousePositionResult.updateMousePosition(event),
      onHover: (event) => mousePositionResult.updateMousePosition(event),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          // Add other styles as needed
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                animation: fillControls,
                builder: (context, child) {
                  return FractionalTranslation(
                    translation: Offset(0, fillControls.value * 0.8),
                    child: child,
                  );
                },
                child: Container(
                  color: Colors.blue, // Adjust the color as needed
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                key: textRef,
                child: Text(
                  widget.child.toString(),
                  style: const TextStyle(
                      // Add text styles as needed
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    fillControls.dispose();
    super.dispose();
  }
}
