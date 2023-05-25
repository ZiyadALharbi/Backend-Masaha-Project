import 'dart:io';

class BaseEnv {
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final ip = InternetAddress.anyIPv4;
}