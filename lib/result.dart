import 'package:ebook_app/resultbook_description.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class ResultBook extends StatelessWidget {
  const ResultBook({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex:4,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: 
          ResultBookDescriptions(),
          
      
        ),
      
      
    );
  }
}