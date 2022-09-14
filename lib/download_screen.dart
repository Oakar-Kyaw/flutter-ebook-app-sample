import 'dart:io';


import 'package:ebook_app/read_screens.dart';

import 'package:firebase_storage/firebase_storage.dart';



import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:ebook_app/constant.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';
import 'database.dart';
import 'ebook_model.dart';
class DownloadScreen extends StatefulWidget{
  final String? imageUrls;
  final String? fileName;
  final String? author;
  final String? description;
  final String? downloadEbookName;
  const DownloadScreen({this.author,this.imageUrls,this.fileName,this.description,this.downloadEbookName});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  List books=[];
  List equalAuthor=[];
   bool isDownloaded=false;
   String paths=""; 
   String progress="";
   String filePaths="";
   List <Map<String,dynamic>> items=[];
   Database _database=Database();
    
   final storageRef=FirebaseStorage.instance.ref();
  @override
  void initState() {
    Stream<QuerySnapshot> streams=FirebaseFirestore.instance.collection('All').snapshots();
    streams.forEach((element) {
      element.docs.asMap().forEach((index,data) {
        String ebookName=element.docs[index]['fileName'];
        String ebookImage=element.docs[index]['imageUrl'];
        String ebookDescription=element.docs[index]['description'];
        String ebookAuthor=element.docs[index]['author'];
        books.add(EbookFile(fileNames:ebookName,authors: ebookAuthor, imageUrls:ebookImage,descriptions: ebookDescription));
        for(int i=0;i<books.length;i++){
           String image=books[i].imageUrls;
                  String fileName=books[i].fileNames;
                  String authors=books[i].authors;
                  String descriptions=books[i].descriptions;
        if(widget.author!.toLowerCase()==authors.toLowerCase() && widget.fileName!.toLowerCase()!=fileName.toLowerCase()){
        equalAuthor.add(EbookFile(fileNames:fileName,authors: authors,imageUrls:image ,descriptions: descriptions));
        }}
        
        
        
       });
    });
    final _ebookBox=Hive.box('ebook_box');

    
    // TODO: implement initState
    super.initState();
  }
 
  downloadFile(fileName,downloadEbook) async{
    Dio dio=Dio();
   final imageUrls=await FirebaseStorage.instance.ref().child("Features/$downloadEbook").getDownloadURL();
   

    String savePath= await getPath(fileName);
     File file = File(savePath);
     await file.create();
    dio.download(imageUrls, savePath,
    onReceiveProgress: (rcv,total){
      setState((){
        progress=((rcv/total) *100).toStringAsFixed(0);
        isDownloading=true;
      });
      if (progress == '100') {
          setState(() {
            isDownloaded = true;
            paths=file.path;
          });
          _database.createBook({'paths':paths,
            'fileNames':widget.fileName,
            'authors':widget.author,
            'imageUrls':widget.imageUrls,
            'descriptions':widget.description});
        }
    }).then((_){
      if (progress=="100"){
      setState(() {
        isDownloaded=true;
        isDownloading=false;
      });
      }
    });
  }
  Future<String> getPath(fileName) async{
    Directory? dir=await getExternalStorageDirectory();
    String paths="${dir!.path}/$fileName.epub";
   
    return paths;
    

  }

 
 
 
  @override
  Widget build(BuildContext context){
    return SafeArea(child:Scaffold(
      
      body:Container(
        color:Color(0xFFF3F2F7),
        child: Stack(

          children:<Widget>[
          isDownloading?
            Positioned.directional(
              textDirection:TextDirection.ltr,
                top:440,
                start:20,
                 end:20,
                bottom:250,
                child:Card(
                  color:Colors.black,
                   elevation:30,
                child:Row(children:[
                  SizedBox(width:20),
                  CircularProgressIndicator(color:Colors.white),
                  SizedBox(width:50),
                  Container(

                      child: Text("Downloading File: $progress %",style:TextStyle(color:Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize:20)))
                ]))):Container(),
           Column(
              children: [
                SizedBox(height:10),
                Expanded(
                  flex:6,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                     Expanded(
                       flex:2,
                       child: Container(
                              height: 300,
                              width: 150,


                               child: Column(
                             children: [
                               Container(
                        width:150,
                        child: Card(
                          elevation:10,
                          child: CachedNetworkImage(
                                imageUrl:'${widget.imageUrls}', placeholder: (context, url) => const CircularProgressIndicator(), ),
                        ),
                               ),
                               SizedBox(height:2),
                              Container(width:145,
                              height:30,
                              child: ElevatedButton.icon(onPressed: () async{

                               if(isDownloaded){



                                 Navigator.of(context).push(MaterialPageRoute(builder: (context){

                                   return ReadingPage(paths);}));}
                               else {  downloadFile(widget.fileName,widget.downloadEbookName);

                              }

                            },

                               icon:isDownloaded? Icon(Icons.book,size: 17,): Icon(Icons.download_for_offline,size: 17,), label:isDownloaded? Text("READ"):Text("DOWNLOAD"))),
                              SizedBox(height:2),

                             ],
                               ),
                             ),
                     ),
                  SizedBox(width: 10,),
                  Expanded(
                   flex:3,
                    child: Container(

                      padding:EdgeInsets.only(top:10,right:7),


                      child:Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                           Text("Book Name: ",style:bookTitleStyle,textAlign: TextAlign.start,),
                           SizedBox(height:10),
                           Text("${widget.fileName}",overflow:TextOverflow.ellipsis, style:TextStyle(fontSize: 15,fontWeight: FontWeight.w200),textAlign: TextAlign.justify,textScaleFactor: 1.1,maxLines: 3,),SizedBox(height:10),
                            Text("Author: ",style:bookTitleStyle,textAlign: TextAlign.start),
                            SizedBox(height:10),
                           Text("${widget.author}",textAlign: TextAlign.justify,style:TextStyle(fontSize: 15,fontWeight: FontWeight.w200), textScaleFactor: 1.1,overflow:TextOverflow.fade,maxLines: 1,),
                        SizedBox(height:10),
                            Text("Genre: ",style:bookTitleStyle,textAlign: TextAlign.start),
                            ElevatedButton(onPressed: (){}, child: Text("Non fiction"),),






                       SizedBox(height: 10,),
                      FlexibleWidget(true,flexNumber: 2),  ],),
                    ),

                  )
                    ],),
                ),
                SizedBox(height: 5,),
              FlexibleWidget(false,flexMoreNumber:3)],
            ),
          ],



    ),
      )));
  }

  Flexible FlexibleWidget(bool isDescription,{flexNumber,flexMoreNumber}) {
    return isDescription?
    Expanded(
     flex:flexNumber,
      child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            Container(
              padding: EdgeInsets.only(right:7),
              alignment: Alignment.topLeft,
              child:Text('Book Description',style:titleStyle)
            ),
             Container(
             padding: EdgeInsets.only(right:7),
              
              child:Divider(color:Colors.black54,thickness: 1.4,),
            ),
           
            SizedBox(height: 5,),
             Container(
             padding: EdgeInsets.only(right:7),
              alignment: Alignment.topLeft,
              child:Text(widget.description!,overflow: TextOverflow.ellipsis,maxLines: 8,
              textScaleFactor: 1.1,)
            ),
            SizedBox(height: 1,),
             Container(
             padding: EdgeInsets.only(right:7),
              alignment: Alignment.bottomRight,
              child:TextButton(child:Text('Show More >>>'),onPressed: (){},)
            ),
             
        
        
      ],)):Expanded(
        flex:flexMoreNumber,
       child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            Container(
              padding: EdgeInsets.only(left:7),
              alignment: Alignment.topLeft,
              child:Text('More From This Author',style:titleStyle)
            ),
             Container(
              padding: EdgeInsets.only(left:7,right: 7),
              
              child:Divider(color:Colors.black54,thickness: 1.4,),
            ),
           
            equalAuthor.isNotEmpty?Container(
              padding: EdgeInsets.only(left:7,right: 7),
              height:100,
              width:500,
              child: ListView.builder(
               
                scrollDirection: Axis.horizontal,
                itemCount:equalAuthor.length,
                itemBuilder:(context,index){
                  String equalimage=equalAuthor[index].imageUrls;
                  String equalfileName=equalAuthor[index].fileNames;
                  String equalauthor=equalAuthor[index].authors;
                  String equaldescription=equalAuthor[index].descriptions;
                  return GestureDetector(
                    onTap:(){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DownloadScreen(fileName: equalfileName,imageUrls: equalimage,description: equaldescription,author:equalauthor,)));},
                    child: Container(
                      width:70,
                      height:100,
                      child: Card(elevation:10 ,
                      child:CachedNetworkImage(imageUrl: equalimage,
                      placeholder: (context,url)=>Center(child:CircularProgressIndicator()),)),
                    ),
                  ) ;
                }),
            )
            :Center(child:Text("There is no Similar Book of this Author")) ],
        ));
  }
}