
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'categories.dart';
import 'feature.dart';
import 'constant.dart';

import 'result.dart';

import 'search_function.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
  return SafeArea(
    child:Scaffold(

      appBar:AppBar(title:Text(widget.title),
    actions: [InkWell(onTap:(){
    
    
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchFunction()));
    },
    child: Icon(Icons.search)),
  SizedBox(width:10)]),
      body:Container(
        color:Color(0xFFF3F2F7),
         // decoration: BoxDecoration(
        //    image:DecorationImage(image:AssetImage(backgroundImage),fit: BoxFit.fill)
         //  ) ,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10,),

            Feature(),
            Categories(),
            ResultBook()
          ],))
    ),
  );
  }

}
