

import 'read_screens.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
class PickFileFromDevice{
pickFile(context) async{
FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,
  allowedExtensions: ['epub'],
);
PlatformFile filePath = result!.files.first; 
Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ReadingPage(filePath.path)));
 
}

}