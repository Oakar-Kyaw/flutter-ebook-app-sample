import 'package:ebook_app/constant.dart';
import 'package:ebook_app/my_book.dart';
import 'package:flutter/material.dart';
import 'my_book_screen.dart';
import 'package:ebook_app/file_picker.dart';
class CategoriesButtons extends StatelessWidget {
  final String? buttonCategory;
  final String? buttonTitle;
  CategoriesButtons({this.buttonTitle,this.buttonCategory});

 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){
      if(buttonCategory=="My_Book"){
        Navigator.of(context).push(MaterialPageRoute(builder:(context)=>MyBook()));
      }
      else if(buttonCategory=="Storage"){
        Navigator.of(context).push(MaterialPageRoute(builder:(context)=>PickFileFromDevice().pickFile(context)));
      }
      },
      child: Container(
        height:40 ,
        width: 90,
        alignment: Alignment.center,
        
        decoration:BoxDecoration(
          color:Colors.blueGrey,
          
          borderRadius: BorderRadius.circular(20),
         
          border:Border.all(color:Colors.blueGrey,
          style:BorderStyle.solid),
          
        ),
        
        child: Text(buttonTitle!,style:caterigorystyle)
      ),
    );
  }
}