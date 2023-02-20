import 'dart:convert';
import 'package:api/2nd.dart';
import 'package:api/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'example.dart';
import 'models/PostsModel.dart';
void main (){
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUp(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  List<PostsModel> postList=[];
  Future<List<PostsModel>> getPostApi() async{
    final response= await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      postList.clear();
      for(Map i in data){
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
  }else{
      return postList;
    }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
             FutureBuilder(
               future: getPostApi(),
                 builder: (context,snapshot){
               if(!snapshot.hasData){
               return  Center(child: CircularProgressIndicator());
               }else{
                 return Expanded(
                   child: ListView.builder(
                     itemCount: postList.length,
                       itemBuilder: (context,index){
                     return Card(
                       child: Text(postList[index].title.toString()),
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

