import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test');
  test('should be subclass of NumberTrivia', () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('fromJson', () {
    test('should return a valid model when the json is int', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });

    test('should return a valid model when the json is doulbe', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, tNumberTriviaModel);
    });

    group('toJson', () {
      test('should return ', () async {
        final result = tNumberTriviaModel.toJson();

        final expectedMap = {
          "text": "test",
          "number": 1,
        };
        expect(result, equals(expectedMap));
      });
    });
  });
}
