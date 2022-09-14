import 'package:ebook_app/constant.dart';
import 'package:ebook_app/feature_description.dart';
import 'package:flutter/material.dart';

import 'constant.dart';
class Feature extends StatelessWidget {
  const Feature({ Key? key }) : super(key: key);

 

   
 

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex:3,
      child:Column(

        children:[
          Container(
            padding: EdgeInsets.only(top: 10,left:10),
           alignment: Alignment.topLeft,
           child: Text('Features',style:titleStyle)),
         SizedBox(height: 10,),
          Container(
            height:190,
            width:500,
            
            padding: EdgeInsets.symmetric(horizontal: 10),
            child:FeatureDescription(),
          //  ),
          ),],
      ),
    );
  }
}