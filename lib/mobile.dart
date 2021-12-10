import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final directory = await getExternalStorageDirectory();
  final path = directory!.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes);
  OpenFile.open('$path/$fileName');
}