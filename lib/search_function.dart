import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/download_screen.dart';
import 'package:ebook_app/service.dart';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'ebook_model.dart';
import 'constant.dart';


class SearchFunction extends StatefulWidget{
  @override
  State<SearchFunction> createState() => _SearchFunctionState();
}

class _SearchFunctionState extends State<SearchFunction> {
   var searchList=[];
   var resultList=[];
   Map nameMap=Map();
   var nameList=[];
   bool isFound=false;
  void initState(){
   Stream<QuerySnapshot> streams=FirebaseFirestore.instance.collection('All').snapshots();
   
   streams.forEach((element) { 
     
     element.docs.asMap().forEach((index,data){
     String  ebookName=element.docs[index]['fileName'];
   
     String  ebookAuthor=element.docs[index]['author'];
     String  ebookImage=element.docs[index]['imageUrl'];
     String  ebookDescription=element.docs[index]['description'];
       return 
    searchList.add(EbookFile(fileNames:ebookName,authors: ebookAuthor,imageUrls:ebookImage,descriptions: ebookDescription));} );
    
   });
   super.initState();
  }
  initialSearch(String value){
    nameList.clear();
    for(int i=0;i<searchList.length;++i){
      String name=searchList[i].fileNames;
      String author=searchList[i].authors;
      String image=searchList[i].imageUrls;
      String description=searchList[i].descriptions;
      if(name.toLowerCase().contains(value.toLowerCase())){
        nameMap['name']=name;
        nameMap['author']=author;
        nameMap['image']=image;
        nameMap['description']=description;
        nameList.add(nameMap);
      }
     
    }
    setState(() {
      
    });
     
  
  }
  Widget build(BuildContext context){
    TextEditingController searchController=TextEditingController();
   
   
    return Scaffold(appBar:AppBar(
      title:Container(
      margin:EdgeInsets.symmetric(vertical:20),
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:Colors.white,
          border:Border.all(width:0.5)
        ),
        child:TextField(
          controller:searchController,
          decoration:InputDecoration(
            icon:Icon(Icons.search),
            hintText:"Search..."
          ),
          onSubmitted: (value) async{
              initialSearch(value);

          },))) ,
          body:Container(
            child:nameList.length != 0 || searchController.text.isNotEmpty?ListView.builder(
              itemCount:nameList.length,
              itemBuilder: (context,index){
                String fileName=nameList[index]['name'];
                
                String imageUrl=nameList[index]['image'];
                String description=nameList[index]['description'];
                String author=nameList[index]['author'];
                return GestureDetector(
                  onTap:(){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DownloadScreen(fileName: fileName,imageUrls: imageUrl,description: description,author:author,)));},
                  child: Card(
                    elevation:10,
                    child: ListTile(leading:Container(
                      decoration: BoxDecoration(shape:BoxShape.rectangle,
                      color:Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                      width:50,
                      height:50,
                      child: CachedNetworkImage(imageUrl:imageUrl ,
                      placeholder:(context,url)=> Center(child: CircularProgressIndicator()),),
                    ),
                    title:Text(fileName),
                    subtitle: Text(author),),
                  ),
                );
              }):Container(),
          )
            );
  
  }
 
}