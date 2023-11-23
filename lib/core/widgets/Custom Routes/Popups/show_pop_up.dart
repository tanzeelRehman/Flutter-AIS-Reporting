import 'package:ais_reporting/core/widgets/Custom%20Routes/widget_extentions.dart';
import 'package:flutter/material.dart';

import 'hero_dialog_route.dart';

Future showPopUp({
  required BuildContext context,
  dynamic data,
  Object heroTag = "",
  Rect? rect,
  required Widget Function(Function onValueSelect) child,
  EdgeInsets padding = EdgeInsets.zero,
  bool animate = true,
  bool shouldScale = false,
  Size size = const Size(0, 0),
}) {
  // print(rect);
  return Navigator.push(
    context,
    HeroDialogRoute(
      builder: (context) => CustomRoute(
        heroTag: heroTag,
        shouldScale: shouldScale,
        rect: rect ??
            Rect.fromCenter(
                center: Offset(MediaQuery.of(context).size.width / 2,
                    MediaQuery.of(context).size.height / 2),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height),
        padding: padding,
        size: size,
        animate: animate,
        child: child,
      ),
    ),
  );
}

class CustomRoute extends StatefulWidget {
  const CustomRoute({
    Key? key,
    required this.heroTag,
    required this.rect,
    required this.child,
    required this.padding,
    required this.size,
    required this.animate,
    required this.shouldScale,
  }) : super(key: key);
  final Object heroTag;
  final Rect rect;
  final Widget Function(Function onValueSelect) child;
  final EdgeInsets padding;
  final Size size;
  final bool animate;
  final bool shouldScale;

  @override
  State<CustomRoute> createState() => _CustomRouteState();
}

class _CustomRouteState extends State<CustomRoute>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  GlobalKey childKey = GlobalKey();
  Size? childSize;

  /// is reponsible for reverse animation and
  /// returns data to the text field
  late Function(dynamic) callBack;
  dynamic valueReturned;
  bool isKeyboaredShow = false;
  @override
  void initState() {
    super.initState();
    callBack = (dynamic value) {
      valueReturned = value;
      controller.reverse();
    };
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        if (controller.isDismissed) {
          Navigator.pop(context, valueReturned);
        }
      });
    if (widget.animate) {
      controller.forward();
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      childSize = childKey.size;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          GestureDetector(
            onTap: () =>
                widget.animate ? controller.reverse() : Navigator.pop(context),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewInsets.bottom != 0
                ? 50
                : (widget.rect.top + widget.padding.top + widget.size.height),
            left: widget.rect.left / 2 + 5,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) => Hero(
                tag: widget.heroTag,
                child: Opacity(
                  opacity: widget.animate ? controller.value : 1,
                  child: Transform.scale(
                    scale: (widget.animate && widget.shouldScale)
                        ? controller.value
                        : 1,
                    child: Transform.translate(
                      offset: Offset(1,
                          widget.animate ? 250 - (controller.value * 250) : 1),
                      child: SizedBox(
                          key: childKey, child: widget.child(callBack)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
