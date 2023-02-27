import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedData {
  static Future<void> saveRole(String role) async {
    FlutterSecureStorage storeref = const FlutterSecureStorage();
    await storeref.write(key: "role", value: role);
  }

  static Future<String?> getRole() async {
    FlutterSecureStorage storeref = const FlutterSecureStorage();
    return await storeref.read(key: "role");
  }
}
