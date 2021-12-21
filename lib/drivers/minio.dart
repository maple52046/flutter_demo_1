import 'package:minio/minio.dart';

final _client = new Minio(
  endPoint: '117.50.175.140',
  accessKey: 'O6Mp3e5C9UEuvoO6MqM3Hn59L1A2rO7T',
  secretKey: 'DC2bGRzcp3b8e0dVA86ukqpMtkT3fc7K',
  port: 32266,
  useSSL: false,
);

Minio getMinioClient() {
  return _client;
}
