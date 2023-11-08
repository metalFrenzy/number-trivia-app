import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/util/input_converter.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToInt', () {
    test('should return an int when the string represents an int', () async {
      final str = '123';
      final result = inputConverter.stringToInt(str);
      expect(result, Right(123));
    });

    test('Should return an Failure when the string in not an int ', () async {
      final str = '1.05';
      final result = inputConverter.stringToInt(str);
      expect(result, Left(InvalidInputFailure()));
    });

    test('Should return an Failure when the string in negative ', () async {
      final str = '-1';
      final result = inputConverter.stringToInt(str);
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
