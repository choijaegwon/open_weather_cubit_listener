import 'package:http/http.dart' as http;

String httpErrorHandler(http.Response response) {
  final stateCode = response.statusCode;
  final reasonPhrase = response.reasonPhrase;

  final String errorMessage =
      'Request failed\nStatus Code: $stateCode\nReason: $reasonPhrase';

  return errorMessage;
}
