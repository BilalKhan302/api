import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? image;
  bool showSpinner=false;
  Future PickImage()async{
    final pickImage= await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 60);
    if(pickImage!=null){
      image=File(pickImage.path);
      setState((){

      });

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Error Occured")));
    }
  }
Future<void> uploadImage()async{
    setState((){
      showSpinner=true;
    });
    var stream=new http.ByteStream(image!.openRead());
    stream.cast();
    var length= await image!.length();
    var uri=Uri.parse("https://fakestoreapi.com/products");
    var request=new http.MultipartRequest("POST", uri);
    request.fields['title']="Static Title";
    var multiport=new http.MultipartFile(
        'image',
        stream,
        length);
    request.files.add(multiport);
    var response= await request.send();
    print(response.stream.toString());
    if(response.statusCode==200){
      setState((){
       showSpinner=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully uploaded")));
      print("Image Uploaded");
      image=null;
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed")));
      print("Failed");
      setState((){
        showSpinner=false;
      });
    }
}
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Column(
          children: [
                Container(
                  height: 300,
                  width: 300,
                  child: image == null ?
                  Container(
                    height: 300,
                    width: 300,
                    child: Center(child: Text('Upload Image'),),
                  ):
                  Container(
                    child: Image.file(
                      File(image!.path).absolute,
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            SizedBox(height: 30,),

            ElevatedButton(onPressed: ()=>ImageUpload(), child: Text('Upload'))
          ],
        ),
      ),
    );
  }
}
