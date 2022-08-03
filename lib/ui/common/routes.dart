import 'package:fluent_ui/fluent_ui.dart';

Route<T> slide<T>(
  dynamic page, {
  double duration = 100,
  Offset startOffset = const Offset(1, 0),
  Curve easeFwd = const ElasticInCurve(),
  Curve easeReverse = const ElasticInOutCurve(),
}) {
  return PageRouteBuilder<T>(
    transitionDuration: Duration(milliseconds: (duration * 2).round()),
    pageBuilder: (context, animation, secondaryAnimation) => page(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      bool reverse = animation.status == AnimationStatus.reverse;
      return SlideTransition(
        position: Tween<Offset>(begin: startOffset, end: const Offset(0, 0))
            .animate(CurvedAnimation(
                parent: animation, curve: reverse ? easeReverse : easeFwd)),
        child: child,
      );
    },
  );
}
