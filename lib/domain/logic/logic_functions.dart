import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

class LogicFunctions {
  static Uint8List convertBytesToImage(Uint8List bodyBytes) {
    var base64 = const Base64Encoder().convert(bodyBytes);
    Uint8List bytes = const Base64Codec().decode(base64);
    return bytes;
  }

  static getImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      return false;
    }
  }
}
