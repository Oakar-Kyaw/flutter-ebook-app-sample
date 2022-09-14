import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


String backgroundImage='assets/image/background.jpg';
enum buttonCategories{All,My_Book,Storage}
final All=buttonCategories.All;
final My_Book=buttonCategories.My_Book;
final Storage=buttonCategories.Storage;

final titleStyle =GoogleFonts.lato(textStyle:TextStyle(color: Colors.black, letterSpacing: .5,fontWeight: FontWeight.bold,fontSize:20),);
final bookTitleStyle =GoogleFonts.lato(textStyle:TextStyle(color: Colors.black, letterSpacing: .5,fontWeight: FontWeight.bold,fontSize:15),);
bool isSearch=false;
bool isSelected=false;
final caterigorystyle=TextStyle(color:Colors.white,fontWeight:FontWeight.bold);
bool isDownloading=false;
