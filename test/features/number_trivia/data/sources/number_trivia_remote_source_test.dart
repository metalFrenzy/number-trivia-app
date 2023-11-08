import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:number_trivia/features/number_trivia/data/sources/number_trivia_remote_source.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteSourceImpl dataSource;
  late MockHttpClient mockClient;

  setUp(() {
    mockClient = MockHttpClient();
    dataSource = NumberTriviaRemoteSourceImpl(mockClient);
  });

  group('getNumbertrivia', () {
    final tNumber = 1;

    test(
        'should perform a get request on a url with the number being the endpoint and the application/json header',
        () async {
      when(
        mockClient.get(Uri.parse('http://numbersapi.com/$tNumber'),
            headers: anyNamed('headers')),
      ).thenAnswer(
        (_) async => http.Response(fixture('trivia.json'), 200),
      );

      dataSource.getNumberTrivia(tNumber);

      verify(
        mockClient.get(Uri.parse('http://numbersapi.com/$tNumber'), headers: {
          'Content-Type': 'application/json',
        }),
      );
    });
  });
}
