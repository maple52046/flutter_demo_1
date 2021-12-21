import 'package:dio/dio.dart';

final _client = new Dio(BaseOptions(
  baseUrl: 'http://tw2.maple52046.tk/parse/api/classes/Products',
  headers: const {'X-Parse-Application-Id': 'OzJ4sdzzOJF516jMIoW4LwLlu45wWBJl'},
));

Dio getParseClient() {
  return _client;
}
