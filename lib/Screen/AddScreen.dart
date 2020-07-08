import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:deliveryapp/services/HotelManagement.dart';

class AddScreen extends StatefulWidget {
  @override
   _AddScreenState createState() => _AddScreenState();
}
class _AddScreenState extends State<AddScreen> {
  
  String _photoUrl = 'empty';
  File photo;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;
   String _uid;
   String url;

  String name = '';
  String address = '';
  String phone = '';
  String type = '';

   getUser() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await firebaseAuth.currentUser();

    if(firebaseUser!=null){
      setState(() {
        this.user = firebaseUser;
        this._uid = firebaseUser.uid;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getUser();
   
  }

     @override
   Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.blue,
         title: Text('Basic Info Add'),
       ),
       body: Container(
         child: Padding(
           padding: EdgeInsets.all(20.0),
           child: ListView(
             children: <Widget>[
               Container(
                 margin: EdgeInsets.only(top: 20.0),
                 child: GestureDetector(
                   onTap: (){
                     this.pickImage();
                   },
                   child: Center(
                     child: Container(
                       width: 100.0,
                       height: 100.0,
                       
                      child: photo == null ? Container(
                        decoration: BoxDecoration(
                         shape: BoxShape.circle,
                         image: DecorationImage(
                           image: AssetImage('assests/images/mascot.png'),
                           fit: BoxFit.cover
                         )
                       )
                      ) : Image.file(photo)
                     )
                   ),
                 ),
               ),
               
               buildContainer('Name'),
               buildContainer('Type'),
               buildContainer('Address'),
               buildContainer('Phone'),

              
               Container(
                 margin: EdgeInsets.only(top: 20.0),
                 child: RaisedButton(
                   onPressed: (){
                    storeValues();
                    Navigator.of(context).pop();
                   },
                   child: Text("Save",style: TextStyle(color: Colors.white),),
                   color: Colors.blue,
                 )
               )
             ],
           ),
         ),
       ),
    );
  }

     Container buildContainer(String fieldName) {
       return Container(
               margin: EdgeInsets.only(top: 20.0),
               child: TextFormField(
                 onChanged: (value){
                   if(fieldName == 'Name'){
                     name = value;
                   }
                   else if(fieldName == 'Type'){
                     type = value;
                   }
                   else if(fieldName == 'Address'){
                     address = value;
                   }
                   else if(fieldName == 'Phone'){
                     phone = value;
                   }
                 },
                 decoration: InputDecoration(
                   labelText: fieldName,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(5.0)
                   )
                 ),
               )
             );
     }

  Future  pickImage() async{
    var temp = await ImagePicker.pickImage(source: ImageSource.gallery,maxHeight: 200.0,maxWidth: 200.0);
    setState(() {
      photo = temp;
    });
  }

  void storeValues() async{
   
     final StorageReference firebaseStroageRef = FirebaseStorage.instance.ref().child(_uid).child('profilePic');
     final StorageUploadTask task = firebaseStroageRef.putFile(photo);

    url = await (await task.onComplete).ref.getDownloadURL();

    print(url);

    var userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.photoUrl = url;
    userUpdateInfo.displayName = name;

     user.updateProfile(userUpdateInfo);
     HotelManagement().hoteBasicInfo(user,type,address,phone,name);
  }

  
} 