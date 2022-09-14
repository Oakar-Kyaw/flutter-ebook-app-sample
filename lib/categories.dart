import 'package:ebook_app/categories_button.dart';
import 'package:ebook_app/constant.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex:1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
       child:Column(
         mainAxisAlignment: MainAxisAlignment.start,
         
         children: [Container(
           alignment: Alignment.topLeft,
           child: Text('Categories',style:titleStyle)),
         SizedBox(height: 5,),
         SingleChildScrollView(
          scrollDirection:Axis.horizontal,
           child: Row(children: [
             
            CategoriesButtons(buttonTitle:"All",buttonCategory:'All'),
             SizedBox(width: 20,),

          CategoriesButtons(buttonTitle:"My Book",buttonCategory:'My_Book'), SizedBox(width: 20,),
          CategoriesButtons(buttonTitle:"Storage",buttonCategory:'Storage'), SizedBox(width: 20,),
          
           ],),
         )],)
      ),
    );
  }
}