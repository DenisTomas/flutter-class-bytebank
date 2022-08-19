import 'package:http/http.dart' as http;
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

http.Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
);

const String baseUrl = 'http://192.168.15.3:8080/transactions';

