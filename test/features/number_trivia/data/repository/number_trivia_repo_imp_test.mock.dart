import 'dart:async' as _i4;

import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/sources/number_trivia_remote_source.dart';

class _FakeNumberTriviaModel_0 extends Fake implements NumberTriviaModel {}

class MockNetworkInfo extends Mock implements NetworkInfo {
  MockNetworkInfo() {
    throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
      Invocation.getter(#isConnected),
      returnValue: Future<bool>.value(false),
      returnValueForMissingStub: Future<bool>.value(true)) as _i4.Future<bool>);
  @override
  String toString() => super.toString();
}

/// A class which mocks [NumberTriviaRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteSource extends Mock
    implements NumberTriviaRemoteSource {
  MockNumberTriviaRemoteDataSource() {
    throwOnMissingStub(this);
  }

  @override
  _i4.Future<NumberTriviaModel>? getConcreteNumberTrivia(int? number) =>
      (super.noSuchMethod(Invocation.method(#getConcreteNumberTrivia, [number]),
              returnValue:
                  Future<NumberTriviaModel>.value(_FakeNumberTriviaModel_0()),
              returnValueForMissingStub:
                  Future<NumberTriviaModel>.value(_FakeNumberTriviaModel_0()))
          as _i4.Future<NumberTriviaModel>?);
  @override
  _i4.Future<NumberTriviaModel> getRandomNumberTrivia() => (super.noSuchMethod(
      Invocation.method(#getRandomNumberTrivia, []),
      returnValue: Future<NumberTriviaModel>.value(_FakeNumberTriviaModel_0()),
      returnValueForMissingStub:
          Future<NumberTriviaModel>.value(_FakeNumberTriviaModel_0())) as _i4
      .Future<NumberTriviaModel>);
  @override
  String toString() => super.toString();
}
