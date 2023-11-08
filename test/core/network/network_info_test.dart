import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/network/network_info.dart';

class MockInternetConnectionChecker extends Mock
    implements InternetConnectionChecker {
  @override
  Future<bool> get hasConnection => super.noSuchMethod(
        Invocation.getter(#hasConnection),
        returnValue: Future<bool>.value(true),
       
      );
}

void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isconnected', () {
    test('should forward the call of InternetConnectionChecker.hasConnection',
        () async {
      final tHasConnection = Future.value(true);
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnection);
      final result = networkInfoImpl.isConnected;
      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, tHasConnection);
    });
  });
}
