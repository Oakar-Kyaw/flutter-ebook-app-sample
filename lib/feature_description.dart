import 'package:card_swiper/card_swiper.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ebook_app/download_screen.dart';

import 'package:flutter/material.dart';
import 'service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
class FeatureDescription extends StatefulWidget {


  
  @override
  State<FeatureDescription> createState() => _FeatureDescriptionState();
}

class _FeatureDescriptionState extends State<FeatureDescription> {
  Service storages=Service();

  final CollectionReference ebookFeaturesCollectionReference = FirebaseFirestore.instance.collection('Features');

  @override
  
  Widget build(BuildContext context) {
    double currentIndex=0;
    return StreamBuilder(
      stream: ebookFeaturesCollectionReference.snapshots(),
      builder: (context,AsyncSnapshot<QuerySnapshot>snapshot) {
        if(snapshot.hasData){
         
        return Swiper(
         
          itemCount:snapshot.data!.docs.length,
          itemBuilder: (context,index) {
           String ebookfileName=snapshot.data!.docs[index]['fileName'];
           String ebookImage=snapshot.data!.docs[index]['imageUrl'];
           String ebookDescription=snapshot.data!.docs[index]['description'];
           String ebookAuthor=snapshot.data!.docs[index]['author'];
           String downloadEbook=snapshot.data!.docs[index]['downloadEbookUrl'];
           
                return InkWell(
                  onTap:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: ((context) => DownloadScreen(imageUrls:ebookImage,author:ebookAuthor,fileName:ebookfileName,description:ebookDescription,
                    downloadEbookName: downloadEbook,))));
                  },
                  child: Card(
                     
                      shape: RoundedRectangleBorder( 
                       
                   
                    borderRadius: BorderRadius.circular(10),  
          
                               ), 
          
                    elevation:10,
                    child: 
                  CachedNetworkImage(
                  placeholder: (context, url) => Center(child: const CircularProgressIndicator()),
                  imageUrl:ebookImage,
                  fit:BoxFit.fitHeight
                
                
                ), ),
                );
              
          },
          viewportFraction: 0.4,
          scale: 0.65,
          
          itemWidth: 150,
          itemHeight: 200,
          layout: SwiperLayout.DEFAULT,
          autoplay: true,
          pagination:const SwiperPagination(builder:DotSwiperPaginationBuilder(activeColor:Colors.blue),
          margin:EdgeInsets.only(top: 70),
          alignment: Alignment.bottomCenter)
            
        );
        }
        
        else{
          return Text("NO DATA");
        }
       
      }
    );
  }
}