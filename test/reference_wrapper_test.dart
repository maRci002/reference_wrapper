import 'package:reference_wrapper/reference_wrapper.dart';
import 'package:test/test.dart';

void twice(Ref<num> x, Ref<num> y) {
  x.ref *= 2;
  y.ref *= 2;
}

void twiceAdvanced(Ref<num> x, Ref<num> y) {
  x(x() * 2);
  y(y() * 2);
}

void changeTo<R, T extends R>(Ref<R> ref, T to) {
  ref(to);
}

void main() {
  group('Ref Tests', () {
    group('Non-nullable Ref:', () {
      late Ref<num> x;
      late Ref<num> y;

      setUp(() {
        x = Ref(5);
        y = Ref(7);
      });

      test('calle method change should affect x and y', () {
        twice(x, y);
        expect(x.ref, 10);
        expect(y.ref, 14);
      });

      test(
          'calle method change should affect x and y '
          'using Callable class syntax', () {
        twiceAdvanced(x, y);
        expect(x(), 10);
        expect(y(), 14);
      });
    });

    group('Nullable Ref:', () {
      late Ref<num?> x;

      setUp(() {
        x = Ref(5);
      });

      test('changeTo method\'s changes should affect x', () {
        changeTo(x, null);
        expect(x.ref, null);
        expect(x(), null);
      });
    });

    group('Type validations:', () {
      test(
          'throws TypeError when nullable generictype is casted '
          'to non-nullable', () {
        expect(
          () => Ref<num?>(11) as Ref<num>,
          throwsA(
            isA<TypeError>(),
          ),
        );
      });

      test(
          'throws TypeError when x is fake casted to nullable and '
          'changeTo tries to set it\'s value to null', () {
        expect(
          // ignore: unnecessary_cast
          () => changeTo(Ref<num>(11) as Ref<num?>, null),
          throwsA(
            isA<TypeError>(),
          ),
        );
      });

      test(
          '== operator should return true if two Ref\'s value are same '
          'and genericType are same', () {
        expect(Ref<num>(11) == Ref<num>(11), true);
      });

      test(
          '== operator should return false if two Ref\'s value are same '
          'and genericType are not same', () {
        expect(Ref<int>(11) == Ref<num>(11), false);
      });

      test(
          '== operator should return false if two Ref\'s value are not same '
          'and genericType are same', () {
        expect(Ref<num>(11) == Ref<num>(10), false);
      });

      test('genericRuntimeType and genericStaticType should be different', () {
        Ref<num> x = Ref<int>(10);
        expect(Ref.genericStaticType(x) == x.genericRuntimeType, false);
      });
    });
  });
}
