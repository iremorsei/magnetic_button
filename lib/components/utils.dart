import 'dart:math';

// Linear interpolation
double distance(double x1, double y1, double x2, double y2) {
  var a = x1 - x2;
  var b = y1 - y2;

  return sqrt(a * a + b * b);
}

// Distance
double lerp(double a, double b, double n) {
  return (1 - n) * a + n * b;
}
