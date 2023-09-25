// import 'package:flutter/material.dart';

// class Button extends StatefulWidget {
//   final String text;
//   final String href;

//   Button({super.key, required this.text, required this.href});

//   @override
//   _ButtonState createState() => _ButtonState();
// }

// class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _animation;
//   Offset _position = Offset.zero;
//   final GlobalKey _containerKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     )..repeat(reverse: true);

//     _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

//     final RenderBox box = _containerKey.currentContext!.findRenderObject() as RenderBox;
//     final rect = box.localToGlobal(Offset.zero) & box.size;
//     const distanceToTrigger = rect.width * 0.7;
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onHover: (event) => setState(() => _position = event.position),
//       onEnter: (event) => _controller.forward(),
//       onExit: (event) => _controller.reverse(),
//       child: GestureDetector(
//         onTap: () => print('Navigate to ${widget.href}'),
//         child: AnimatedBuilder(
//           animation: _animation,
//           builder: (context, child) => Transform.translate(
//             offset: Offset(
//                 (_position.dx - MediaQuery.of(context).size.width / 2) * 0.2,
//                 (_position.dy - MediaQuery.of(context).size.height / 2) * 0.2),
//             child: child,
//           ),
//           child: Container(
//             padding: const EdgeInsets.all(10.0),
//             decoration: BoxDecoration(
//               color: Colors.blue,
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             child: Text(widget.text),
//           ),
//         ),
//       ),
//     );
//   }
// }
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
    return MousePositionExample(
      onEnter: (event) {
        mouseX = event.localPosition.dx;
        mouseY = event.localPosition.dy;
      },
      onExit: (_) {
        mouseX = null;
        mouseY = null;
      },
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
