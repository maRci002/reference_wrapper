/// Wraps an arbitary object, if caller method pass [Ref] to callee method, then
/// any changes made on [Ref.ref] will affect caller too.
///
/// There are two ways to read / write the value:
///
/// ```dart
/// var x = Ref<num?>(null);
/// x.ref;      // first way to read
/// x();        // second way to read
///
/// x.ref = 10; // first way to write
/// x(15);      // second way to write
/// ```
///
/// **Example:**
/// ```dart
/// void twice(Ref<num> x, Ref<num> y) {
///   x.ref *= 2;
///   y.ref *= 2;
/// }
///
/// void test() {
///   var x = Ref<num>(5);
///   var y = Ref<num>(7);
///
///   twice(x, y);
///   print(x.ref); // 10
///   print(y.ref); // 14
/// }
/// ```
///
/// **Advanced Example:**
/// ```dart
/// void twiceAdvanced(Ref<num> x, Ref<num> y) {
///   x(x() * 2);
///   y(y() * 2);
/// }
///
/// void test() {
///   var x = Ref<num>(5);
///   var y = Ref<num>(7);
///
///   twiceAdvanced(x, y);
///   print(x()); // 10
///   print(y()); // 14
/// }
/// ```
abstract class Ref<T> {
  Ref._();

  factory Ref(T ref) = _Ref;

  T get ref;

  set ref(T ref);

  T call([T ref]);

  Type get genericRuntimeType;

  static Type genericStaticType<S>(Ref<S> ref) => S;

  @override
  String toString() => 'Ref(ref: $ref)';
}

class _Undefined {}

class _Ref<T> extends Ref<T> {
  @override
  T ref;

  _Ref(this.ref) : super._();

  @override
  T call([Object? ref = _Undefined]) {
    return identical(ref, _Undefined) ? this.ref : this.ref = ref as T;
  }

  @override
  Type get genericRuntimeType => T;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is _Ref<T> &&
        other.genericRuntimeType == genericRuntimeType &&
        other.ref == ref;
  }

  @override
  int get hashCode => ref.hashCode;
}
