import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'database.dart';

import 'package:ebook_app/read_screens.dart';
import 'package:cached_network_image/cached_network_image.dart';
class MyBook extends StatefulWidget {
  const MyBook({Key? key}) : super(key: key);



  @override
  State<MyBook> createState() => _MyBookState();
}

class _MyBookState extends State<MyBook> {

  List <Map<String,dynamic>> items=[];
  Database _database=Database();
  void initState(){
    openbox();
    super.initState();
  }
  openbox(){
    final _ebookBox=Hive.box('ebook_box');
    final data=_ebookBox.keys.map((key){

      final value=_ebookBox.get(key);
      return {'key':key,'path':value['paths'],'fileName':value['fileNames'],'imageUrls':value['imageUrls'],
      'description':value['descriptions'],'author':value['authors']};
    }).toList();
    print('data are $data');
    setState((){
      items=data.reversed.toList();
    });



  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(



          body:Container(
              color:Color(0xFFF3F2F7),
              child:ListView.builder(
                itemCount:items.length,
                itemBuilder: (context,index) {
                  final currentItem=items[index];
                  return Card(elevation:20,
                  child:ListTile(title:Text('${currentItem['fileName']}'),
                      leading:CachedNetworkImage(
                        imageUrl:'${currentItem['imageUrls']}', placeholder: (context, url) => const CircularProgressIndicator(), ),
                      subtitle:Text('${currentItem['author']}'),
                  trailing:ElevatedButton(child:Text("READ"),onPressed:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){

                      return ReadingPage(currentItem['path']);}
                    ));
                  }
                    )
                  )
                  );
                }
              )
              )
      ),
    );
  }

}
