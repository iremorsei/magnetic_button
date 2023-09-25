import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math';

import 'components/utils.dart';

class MagneticButton extends StatefulWidget {
  final Widget child;
  final GlobalKey<MagneticButtonState>? innerMagneticButtonKey;

  const MagneticButton({
    Key? key,
    required this.child,
    this.innerMagneticButtonKey,
  }) : super(key: key);

  @override
  State<MagneticButton> createState() => MagneticButtonState();
}

class MagneticButtonState extends State<MagneticButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  double _textX = 0.0;
  double _textY = 0.0;

  bool mouseIsHovering = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    // Use an easing curve for the animation.
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCirc,
      reverseCurve: Curves.easeInCirc,
    );

    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _textX = 0.0;
          _textY = 0.0;
        });
        _animationController.reverse();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startMouseListeners();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleMouseEnter(PointerEnterEvent event) {}

  void _handleMouseLeave(PointerExitEvent event) {
    mouseIsHovering = false;
    // Check if mouse is still hovering over inner MagneticButton
    if (widget.innerMagneticButtonKey != null &&
        !widget.innerMagneticButtonKey!.currentState!.mouseIsHovering) {
      setState(() {
        _textX = 0.0;
        _textY = 0.0;
      });
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_animationController.isDismissed) {
        _animationController.forward();
      }
    });
  }

  void _startMouseListeners() {
    // Listen to mouse events.
    RendererBinding.instance.pointerRouter.addGlobalRoute((PointerEvent event) {
      if (event is PointerHoverEvent) {
        _handleMouseMove(event);
      } else if (event is PointerEnterEvent) {
        _handleMouseEnter(event);
      } else if (event is PointerExitEvent) {
        _handleMouseLeave(event);
      }
    });
  }

  void _handleMouseMove(PointerHoverEvent event) {
    // Get the RenderBox of the widget.
    final RenderBox renderBox = context.findRenderObject() as RenderBox;

    // Calculate the distance to trigger the animation.
    final double distanceToTrigger = renderBox.size.width * 0.7;

    // Calculate the position of the mouse relative to the center of the button.
    final double relX = event.position.dx -
        (renderBox.localToGlobal(Offset.zero).dx + renderBox.size.width / 2);
    final double relY = event.position.dy -
        (renderBox.localToGlobal(Offset.zero).dy + renderBox.size.height / 2);

    final double distanceMouseButton = distance(
        event.position.dx,
        event.position.dy,
        renderBox.localToGlobal(Offset.zero).dx + renderBox.size.width / 2,
        renderBox.localToGlobal(Offset.zero).dy + renderBox.size.height / 2);

    if (distanceMouseButton < distanceToTrigger) {
      // If the mouse is close enough, move the button and its text.
      setState(() {
        _textX = relX * 0.2;
        _textY = relY * 0.2;
      });
    } else {
      // If the mouse is not close enough, reset the button and its text to their original positions.
      setState(() {
        _textX = 0.0;
        _textY = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _handleMouseEnter,
      onExit: _handleMouseLeave,
      onHover: _handleMouseMove,
      child: Transform.translate(
        offset: Offset(
            _textX * (1 - _animation.value), _textY * (1 - _animation.value)),
        child: Transform.translate(
          offset: Offset(_textX / 4 * (1 - _animation.value),
              _textY / 4 * (1 - _animation.value)),
          child: widget.child,
        ),
      ),
    );
  }
}
