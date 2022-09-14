
import 'package:hive/hive.dart';

class Database{
  
  final _ebookFile= Hive.box('ebook_box');
  Future createBook(Map<String,dynamic>newItems) async{
    await _ebookFile.add(newItems);
  }
  Map<String,dynamic> readEbookItem(int keys){
    final _item=_ebookFile.get(keys);
    return _item;
  }
  
  
}