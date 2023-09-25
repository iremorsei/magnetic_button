import 'dart:math';

// Linear interpolation
// Calculate the distance between the mouse and the center of the button.
double distance(double x1, double y1, double x2, double y2) {
  var a = x1 - x2;
  var b = y1 - y2;

  return sqrt(pow(a, 2) + pow(b, 2));
}

// Distance
double lerp(double a, double b, double n) {
  return (1 - n) * a + n * b;
}
