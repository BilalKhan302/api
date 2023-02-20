import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'models/ProductsModel.dart';
class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  Future<ProductsModel> getApi()async{
 final response= await http.get(Uri.parse('https://webhook.site/4fdd6262-0858-4719-8051-edd2c75a542a'));
 var data =jsonEncode(response.body.toString());
 if(response.statusCode==200){
   return ProductsModel.fromJson(data);
 }else{
   return ProductsModel.fromJson(data);
 }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: getApi(),
              builder: (context,AsyncSnapshot<ProductsModel>snapshot){
                if(snapshot.hasData){
            return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data!.data!.length,
                  itemBuilder: (context,index){
                    return Column(
                      children: [
                        Text(index.toString())
                      ],
                    );
              }),
            );}else{
                  return Text("Loading");
                }
          })
        ],
      ),
    );
  }
}
