import 'dart:convert';

import 'package:number_trivia/core/errors/expections.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalSource {
  Future<NumberTriviaModel>? getLastNumberTrivia();
  Future<void>? cachNumberTrivia(NumberTriviaModel trivia);
}

const key = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalSourceImp implements NumberTriviaLocalSource {
  final SharedPreferences sharedPreferences;
  NumberTriviaLocalSourceImp(this.sharedPreferences);

  @override
  Future<NumberTriviaModel>? getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(key);
    if (jsonString != null) {
      return Future.value(
        NumberTriviaModel.fromJson(
          json.decode(jsonString),
        ),
      );
    } else {
      throw CacheExpection();
    }
  }

  @override
  Future<void>? cachNumberTrivia(NumberTriviaModel trivia) {
    return sharedPreferences.setString(
      key,
      json.encode(
        trivia.toJson(),
      ),
    );
  }
}
