import 'dart:async';
import 'dart:math';

class AnimationProvider {
  AnimationProvider(
      {required this.duration,
      required this.callback,
      required this.translationFirst});

  final Duration duration;
  final Function() callback;
  bool translationFirst;
  Timer? _timer;
  double _value = 1;
  DateTime _startTime = DateTime.now();

  double get rotateAndShearFactor {
    double result = translationFirst ? 0 : 1;
    if (translationFirst && _value > 0.5) {
      result = (_value - 0.5) * 2;
    }
    if (!translationFirst && _value < 0.5) {
      result = _value * 2;
    }
    return result;
  }

  double get moveFactor {
    double result = translationFirst ? 1 : 0;
    if (translationFirst && _value < 0.5) {
      result = _value * 2;
    }
    if (!translationFirst && _value > 0.5) {
      result = (_value - 0.5) * 2;
    }
    return result;
  }

  void startAnimation() {
    // do not run 2 timers
    if (_timer != null) {
      return;
    }
    _startTime = DateTime.now();
    _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      var goneMilliSeconds =
          DateTime.now().difference(_startTime).inMilliseconds;
      double x = goneMilliSeconds / duration.inMilliseconds;
      // formula for easeOutCubic was taken from Gemini
      _value = 1.0 - pow(1 - x, 3);
      callback();
      if (x > 1) {
        timer.cancel();
        _timer = null;
      }
    });
  }

  void stopAnimation() {
    _timer?.cancel();
    _timer = null;
  }
}
