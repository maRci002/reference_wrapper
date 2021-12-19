`Reference Wrapper` is a Dart package which simulates `pass by reference` feature using Wrapper class which holds the value.

# Usage
> Use this package if you are calling a function that needs to modify its arguments

## There are two ways to read / write the value

```dart
var x = Ref<num?>(null);
var read1 = x.ref;      // first way to read
var read2 = x();        // second way to read

x.ref = 10;             // first way to write
x(10);                  // second way to write
```

## Example
```dart
void twice(Ref<num> x, Ref<num> y) {
  x.ref *= 2;
  y.ref *= 2;
}

void test() {
  var x = Ref<num>(5);
  var y = Ref<num>(7);

  twice(x, y);
  print(x.ref); // 10
  print(y.ref); // 14
}
```

## Advanced Example
```dart
void twice(Ref<num> x, Ref<num> y) {
  x(x() * 2);
  y(y() * 2);
}

void test() {
  var x = Ref<num>(5);
  var y = Ref<num>(7);

  twice(x, y);
  print(x()); // 10
  print(y()); // 14
}
```