import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/PostsModel.dart';
class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  List<PostsModel> list=[];
  Future<List<PostsModel>> getApi()async{
    final response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data=jsonDecode(response.body.toString());
      if(response.statusCode==200){
        for(Map i in data){
          list.add(PostsModel.fromJson(i));
        }
        return list;
      }else{
       return list;
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
            future: getApi(),
              builder: (context,snapshot){
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }else{
                return Expanded(
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context,index){
                        return Card(
                          child: Text(list[index].body.toString()),
                        );
                  }),
                );
              }
          })
        ],
      ),
    );
  }
}
