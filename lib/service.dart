import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

import 'constant.dart';
String? taskid;
class Service{
  final FirebaseStorage storage=FirebaseStorage.instance;
  

  Future<ListResult> listAll() async{
    ListResult result= await storage.ref('Features').listAll();
    result.items.forEach((Reference ref) { 
      print(ref);
    });
    return result;

  }
  
  Future<String> downloadUrl(String imageName) async{
    String downloadurl= await storage.ref('Features/the great gasby/https://firebasestorage.googleapis.com/v0/b/ebook-90cd2.appspot.com/o/Features%2Fthe%20great%20gatsby%2Fthe%20great%20gatsby.jpg?alt=media&token=0de3dab2-2b3e-4ebf-b2a1-87d5f41ffbba').getDownloadURL();
    print('DownloadUrl is $downloadurl');
    //https://firebasestorage.googleapis.com/v0/b/ebook-90cd2.appspot.com/o/Features%2Fthe%20great%20gatsby%2Fthe%20great%20gatsby.jpg?alt=media&token=0de3dab2-2b3e-4ebf-b2a1-87d5f41ffbba
    return downloadurl;
  }
   Future<ListResult> allBooks() async{
    ListResult result= await storage.ref('All').listAll();
    
    return result;

  }
  Future<String> downloadAllUrl(String imageUrl) async{
    String downloadurl= await storage.ref('All/$imageUrl').getDownloadURL();
    return downloadurl;
  }
}
Future  queryData(String data) async{
  return FirebaseFirestore.instance.collection('All').where('fileName',
  isGreaterThanOrEqualTo: data,).get();
}



   
 

class SearchService{
  searchByName(String value){
   var document= FirebaseFirestore.instance.collection("All").where( 
      'searchKey',isEqualTo: value.substring(0,1).toUpperCase()
    ).get();
    print("Document is $document");
    return document;
  }
}