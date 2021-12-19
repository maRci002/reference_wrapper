import 'package:reference_wrapper/reference_wrapper.dart';

void twice(Ref<num> x, Ref<num> y) {
  x.ref *= 2;
  y.ref *= 2;
}

void twiceAdvanced(Ref<num> x, Ref<num> y) {
  x(x() * 2);
  y(y() * 2);
}

void main() {
  var x = Ref<num>(5);
  var y = Ref<num>(7);

  twice(x, y);
  print(x.ref); // 10
  print(y.ref); // 14

  twiceAdvanced(x, y);
  print(x()); // 20
  print(y()); // 28
}
