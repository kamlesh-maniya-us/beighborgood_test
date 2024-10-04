
import 'package:permission_handler/permission_handler.dart';

Future<PermissionStatus> storagePermission() async {
  final PermissionStatus status = await Permission.storage.request();
  return status;
}