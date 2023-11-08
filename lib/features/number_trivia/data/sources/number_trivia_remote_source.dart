import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/errors/expections.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteSource {
  Future<NumberTriviaModel>? getNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteSourceImpl implements NumberTriviaRemoteSource {
  final http.Client client;
  NumberTriviaRemoteSourceImpl(this.client);
  @override
  Future<NumberTriviaModel>? getNumberTrivia(int number) async {
    final respone =
        await client.get(Uri.parse('http://numbersapi.com/$number'), headers: {
      'Content-Type': 'application/json',
    });
    if (respone.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(respone.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async{
     final respone =
        await client.get(Uri.parse('http://numbersapi.com/random'), headers: {
      'Content-Type': 'application/json',
    });
    if (respone.statusCode == 200) {
      return NumberTriviaModel.fromJson(json.decode(respone.body));
    } else {
      throw ServerException();
    }
  }
}
