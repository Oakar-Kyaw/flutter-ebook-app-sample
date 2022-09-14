import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebook_app/constant.dart';
import 'package:ebook_app/service.dart';
import 'package:ebook_app/download_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
class ResultBookDescriptions extends StatelessWidget {
  Service storages=Service();
  final CollectionReference ebookCollectionfiles=FirebaseFirestore.instance.collection('All');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:ebookCollectionfiles.snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData){
        return ListView.separated(
            scrollDirection: Axis.vertical,
          separatorBuilder: (context, index) => SizedBox(height:10),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context,index) {
            String ebookNames=snapshot.data!.docs[index]['fileName'];
            String ebookAuthor=snapshot.data!.docs[index]['author'];
            String ebookImageUrl=snapshot.data!.docs[index]['imageUrl'];
            String ebookDescription=snapshot.data!.docs[index]['description'];
            return Container(child:Row(
                    mainAxisAlignment:MainAxisAlignment.start,
                    children:[InkWell(
                      onTap:(){ Navigator.of(context).push(MaterialPageRoute(builder: ((context) => DownloadScreen(imageUrls:ebookImageUrl,author:ebookAuthor,fileName:ebookNames,description:ebookDescription))));},
                      child: Container(
                        alignment: Alignment.topLeft,
                                  height: 120,
                                  width:120,
                                  decoration: BoxDecoration(
                                    
                                    borderRadius: BorderRadius.all(Radius.circular(15),
                                    ),
                                    
                                  ),
                                child:CachedNetworkImage(imageUrl:ebookImageUrl,placeholder: (context,url)=>Center(child:CircularProgressIndicator()),)),
                    ),
                   SizedBox(width: 5,),
                   Container(
                     padding: EdgeInsets.only(top:20),
                     height: 135,
              width:220,alignment: Alignment.topLeft,
                   child:Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(ebookNames,maxLines: 1,overflow:TextOverflow.ellipsis,style:TextStyle(fontSize: 15,fontWeight: FontWeight.w600)),
                       SizedBox(height:20),
                       Text(ebookAuthor,maxLines: 1,overflow:TextOverflow.ellipsis,style:TextStyle(fontSize: 15,fontWeight: FontWeight.w200)),
                     ],
                   )) ],)); 
          }
        );
        }
        else{return Text(" ") ;};
      }
    );
  }
}