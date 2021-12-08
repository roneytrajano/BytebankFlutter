import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(data.statusCode);
    print(data.headers);
    print(data.body);
    return data;
  }

}

void findAll() async{
  Client client = InterceptedClient.build(interceptors: [
    LoggingInterceptor(),
  ]);

  final Response response = await client.get(Uri.parse('http://192.168.0.101:8080/transactions'));
}