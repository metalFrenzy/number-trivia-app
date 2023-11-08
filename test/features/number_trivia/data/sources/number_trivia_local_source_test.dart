import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/errors/expections.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/sources/number_trivia_local_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {
  @override
  Future<bool> setString(String key, String value) => super.noSuchMethod(
        Invocation.method(#setString, [key,value]),
        returnValue: Future<bool>.value(false),
        returnValueForMissingStub: Future<bool>.value(false),
      );
}

void main() {
  late NumberTriviaLocalSourceImp dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalSourceImp(mockSharedPreferences);
  });
  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test(
        'should retrun NumberTrivia from sshared preferences if there is a cache',
        () async {
      when(mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'))
          .thenReturn(fixture('trivia_cached.json'));

      final result = await dataSource.getLastNumberTrivia();

      verify(mockSharedPreferences.getString(key));
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw cache expection when there is no cache value', () async {
      when(mockSharedPreferences.getString('CACHED_NUMBER_TRIVIA'))
          .thenReturn(null);

      final call = dataSource.getLastNumberTrivia;

      expect(
        () => call(),
        throwsA(
          TypeMatcher<CacheExpection>(),
        ),
      );
    });
  });

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel(text: 'trivia text', number: 1);
    test('should call SharedPreferences to cache data', () async {
      dataSource.cachNumberTrivia(tNumberTriviaModel);

      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());

      verify(mockSharedPreferences.setString(
        key,
        expectedJsonString,
      ));
    });
  });
}
