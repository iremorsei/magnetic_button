library magnetic_button;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'components/utils.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MagneticButton extends StatefulWidget {
  final Widget child;

  /// This is the horizontal offset of the magnetic widget. It determines how much the button moves in the horizontal direction (left or right) when it’s being interacted with. A larger value will result in a greater horizontal movement.
  final double mx;

  /// This is the vertical offset of the magnetic widget. It controls how much the button moves in the vertical direction (up or down) during interaction. A larger value will result in a greater vertical movement
  final double my;

  /// The duration of the animation.
  final Duration duration;

  /// Determines the proximity at which an animation for a widget is initiated. Default value is 70% of the width of the render box.
  final double distance;

  /// The curve of the animation.
  final Curve curve;

  /// The height of the magnetic widget. This is an optional parameter.
  final double? height;

  /// The width of the magnetic widget. This is an optional parameter.
  final double? width;

  /// The padding around the magnetic widget. This is an optional parameter.
  final EdgeInsets? padding;

  /// A boolean value indicating whether the widget should respond to long press events on mobile. If false only Web will work.
  final bool mobile;

  /// A nullable callback function called when an `Offset` change event occurs.
  final ValueChanged<Offset>? onChanged;

  const MagneticButton({
    Key? key,
    required this.child,
    this.mx = 0.2,
    this.my = 0.2,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutCirc,
    this.height,
    this.width,
    this.padding,
    this.mobile = true,
    this.onChanged,
    this.distance = 0.7,
  }) : super(key: key);

  @override
  State<MagneticButton> createState() => MagneticButtonState();
}

class MagneticButtonState extends State<MagneticButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  final Key key = GlobalKey();

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
      curve: widget.curve,
      reverseCurve: widget.curve,
    );

    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(widget.duration, () {
          if (_animationController.status != AnimationStatus.forward) {
            _animationController.reverse();
          }
        });
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
    if (!mouseIsHovering) {
      setState(() {
        _textX = 0.0;
        _textY = 0.0;
        if (widget.onChanged != null) widget.onChanged!(const Offset(0, 0));
      });
      if (_animationController.status != AnimationStatus.forward) {
        _animationController.forward();
      }
    }
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
    if (!mounted) return;

    // Get the RenderBox of the widget.
    final RenderBox renderBox = context.findRenderObject() as RenderBox;

    // Calculate the distance to trigger the animation.
    final double distanceToTrigger = renderBox.size.width * widget.distance;

    // Get the global position of the widget.
    final Offset globalPosition = renderBox.localToGlobal(Offset.zero);

    final double distanceMouseButton = distance(
        event.position.dx,
        event.position.dy,
        globalPosition.dx + renderBox.size.width / 2,
        globalPosition.dy + renderBox.size.height / 2);

    if (distanceMouseButton < distanceToTrigger) {
      // Calculate the position of the mouse relative to the center of the button.
      final double relX =
          event.position.dx - (globalPosition.dx + renderBox.size.width / 2);
      final double relY =
          event.position.dy - (globalPosition.dy + renderBox.size.height / 2);

      // If the mouse is close enough, move the button and its text.
      setState(() {
        _textX = relX * widget.mx;
        _textY = relY * widget.my;
        if (widget.onChanged != null) widget.onChanged!(Offset(_textX, _textY));
      });
    } else if (_textX != 0.0 || _textY != 0.0) {
      // If the mouse is not close enough, reset the button and its text to their original positions.
      setState(() {
        _textX = 0.0;
        _textY = 0.0;
        if (widget.onChanged != null) widget.onChanged!(Offset(_textX, _textY));
      });
    }
  }

  void _handleHoldMove(LongPressMoveUpdateDetails details) {
    if (!mounted) return;

    // Get the RenderBox of the widget.
    final RenderBox renderBox = context.findRenderObject() as RenderBox;

    // Calculate the distance to trigger the animation.
    final double distanceToTrigger = renderBox.size.width * widget.distance;

    // Get the global position of the widget.
    final Offset globalPosition = renderBox.localToGlobal(Offset.zero);

    final double distanceMouseButton = distance(
        details.localPosition.dx,
        details.localPosition.dy,
        globalPosition.dx + renderBox.size.width / 2,
        globalPosition.dy + renderBox.size.height / 2);

    if (distanceMouseButton < distanceToTrigger) {
      // Calculate the position of the hold position relative to the center of the button.
      final double relX = details.localPosition.dx -
          (globalPosition.dx + renderBox.size.width / 2);
      final double relY = details.localPosition.dy -
          (globalPosition.dy + renderBox.size.height / 2);

      // If the hold position is close enough, move the button and its text.
      setState(() {
        _textX = relX * widget.mx;
        _textY = relY * widget.my;
        if (widget.onChanged != null) widget.onChanged!(Offset(_textX, _textY));
      });
    } else if (_textX != 0.0 || _textY != 0.0) {
      // If the hold position is not close enough, reset the button and its text to their original positions.
      setState(() {
        _textX = 0.0;
        _textY = 0.0;
        if (widget.onChanged != null) widget.onChanged!(Offset(_textX, _textY));
      });
    }
  }

  // If hold is not pressed or exit, reset the button and its text to their original positions.
  void _handleHoldLeave() {
    setState(() {
      _textX = 0.0;
      _textY = 0.0;
      widget.onChanged!(Offset(_textX, _textY));
    });

    if (_animationController.status != AnimationStatus.forward) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? _buildWeb()
        : widget.mobile
            ? _buildMobile()
            : _buildWeb();
  }

  Widget _buildWeb() {
    return MouseRegion(
        onEnter: _handleMouseEnter,
        onExit: _handleMouseLeave,
        onHover: _handleMouseMove,
        child: _buildAnimatedContainer());
  }

  Widget _buildMobile() {
    return GestureDetector(
      onLongPressMoveUpdate: (details) => _handleHoldMove(details),
      onLongPressEnd: (details) => _handleHoldLeave(),
      child: _buildAnimatedContainer(),
    );
  }

  Widget _buildAnimatedContainer() {
    return AnimatedContainer(
      key: key,
      duration: widget.duration,
      height: widget.height,
      width: widget.width,
      padding: widget.padding,
      transform: Matrix4.translationValues(
        _textX * (1 - _animation.value),
        _textY * (1 - _animation.value),
        0.0,
      ),
      child: widget.child,
    );
  }
}
