import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:number_trivia/core/errors/expections.dart';
import 'package:number_trivia/core/errors/failure.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/repository/number_trivia_repo_impl.dart';
import 'package:number_trivia/features/number_trivia/data/sources/number_trivia_local_source.dart';
import 'package:number_trivia/features/number_trivia/data/sources/number_trivia_remote_source.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'number_trivia_repo_imp_test.mock.dart';

class MocklocalSource extends Mock implements NumberTriviaLocalSource {}

 @GenerateMocks([NetworkInfo])
//  @GenerateMocks([NumberTriviaRemoteSource])
@GenerateMocks([
  NumberTriviaRemoteSource
], customMocks: [
  MockSpec<NumberTriviaRemoteSource>(
      as: #MockRemoteSource,
      returnNullOnMissingStub: true),
])
void main() {
  late NumberTriviaRepoImpl repo;
  late MockRemoteSource mockRemoteSource;
  late MocklocalSource mocklocalSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteSource = MockRemoteSource();
    mocklocalSource = MocklocalSource();
    mockNetworkInfo = MockNetworkInfo();
    repo = NumberTriviaRepoImpl(
      remote: mockRemoteSource,
      local: mocklocalSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getNumbertrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel(text: 'text', number: tNumber);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repo.getNumberTrivia(tNumber);
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return remote data when the call to remote is sucess',
          () async {
        when(mockRemoteSource.getNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repo.getNumberTrivia(tNumber);
        verify(mockRemoteSource.getNumberTrivia(tNumber));
        expect(result, equals(Right(tNumberTrivia)));
      });

      test('should cache the data locally when the call to remote is sucess',
          () async {
        when(mockRemoteSource.getNumberTrivia(tNumber))
            .thenAnswer((_) async => tNumberTriviaModel);
        await repo.getNumberTrivia(tNumber);
        verify(mockRemoteSource.getNumberTrivia(tNumber));
        verify(mocklocalSource.cachNumberTrivia(tNumberTriviaModel));
      });

      test(
          'should return server failure  when the call to remote is unsucessful',
          () async {
        when(mockRemoteSource.getNumberTrivia(tNumber))
            .thenThrow(ServerException());
        final result = await repo.getNumberTrivia(tNumber);
        verify(mockRemoteSource.getNumberTrivia(tNumber));
        verifyZeroInteractions(mocklocalSource);
        expect(result, equals(left(ServerFaliure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
          'should return last locally cached data when cached data is present ',
          () async {
        when(mocklocalSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repo.getNumberTrivia(tNumber);
        verifyNoMoreInteractions(mockRemoteSource);
        verify(mocklocalSource.getLastNumberTrivia());
        expect(result, equals(right(tNumberTrivia)));
      });

      test('should return cache failure when there is no cached data present',
          () async {
        when(mocklocalSource.getLastNumberTrivia()).thenThrow(CacheExpection());
        final result = await repo.getNumberTrivia(tNumber);
        verifyNoMoreInteractions(mockRemoteSource);
        verify(mocklocalSource.getLastNumberTrivia());
        expect(result, equals(left(CacheFaliure())));
      });
    });
  });

  //random
  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel(text: 'test trivia', number: 123);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;

    test('should check if device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repo.getRandomNumberTrivia();
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test('should return remote data when the call to remote is sucess',
          () async {
        when(mockRemoteSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repo.getRandomNumberTrivia();
        verify(mockRemoteSource.getRandomNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      });

      test('should cache the data locally when the call to remote is sucess',
          () async {
        when(mockRemoteSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        await repo.getRandomNumberTrivia();
        verify(mockRemoteSource.getRandomNumberTrivia());
        verify(mocklocalSource.cachNumberTrivia(tNumberTriviaModel));
      });

      test(
          'should return server failure  when the call to remote is unsucessful',
          () async {
        when(mockRemoteSource.getRandomNumberTrivia())
            .thenThrow(ServerException());
        final result = await repo.getRandomNumberTrivia();
        verify(mockRemoteSource.getRandomNumberTrivia());
        verifyZeroInteractions(mocklocalSource);
        expect(result, equals(left(ServerFaliure())));
      });
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test(
          'should return last locally cached data when cached data is present ',
          () async {
        when(mocklocalSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        final result = await repo.getRandomNumberTrivia();
        verifyNoMoreInteractions(mockRemoteSource);
        verify(mocklocalSource.getLastNumberTrivia());
        expect(result, equals(right(tNumberTrivia)));
      });

      test('should return cache failure when there is no cached data present',
          () async {
        when(mocklocalSource.getLastNumberTrivia()).thenThrow(CacheExpection());
        final result = await repo.getRandomNumberTrivia();
        verifyNoMoreInteractions(mockRemoteSource);
        verify(mocklocalSource.getLastNumberTrivia());
        expect(result, equals(left(CacheFaliure())));
      });
    });
  });
}

