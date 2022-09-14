import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:epub_viewer/epub_viewer.dart';

class ReadingPage  extends StatelessWidget{
  
  final String? filePath;
  ReadingPage(this.filePath);
 openEpubFiles(context,filePaths){
  EpubViewer.setConfig(
  themeColor: Theme.of(context).primaryColor,
  identifier: "iosBook",
  scrollDirection: EpubScrollDirection.HORIZONTAL,
  allowSharing: true,
  enableTts: true,
);

/**
* @bookPath
* @lastLocation (optional and only android)
*/
EpubViewer.open(
  filePaths,
   // first page will open up if the value is null
);

// Get locator which you can save in your database
}
 Widget build(BuildContext context){
   return Scaffold(body:openEpubFiles(context, filePath));
 }
  
}