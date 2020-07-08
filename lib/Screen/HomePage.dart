import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'AddScreen.dart';
import 'package:deliveryapp/services/HotelManagement.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';


class HomePage extends StatefulWidget {
  @override
   _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

 
   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
   FirebaseUser user;
   String _uid;
   Stream hotelinfo;
   String hotelName='',hotelType='';

   HotelManagement hotelManagement = HotelManagement();


     getUser() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await firebaseAuth.currentUser();

    if(firebaseUser!=null){
      setState(() {
        this.user = firebaseUser;
        this._uid = firebaseUser.uid;
        hotelInfo();
      });
    }
  }

  void hotelInfo()async{

       await Firestore.instance.collection('HotelManagement').document(_uid).get().then((value){
         setState(() {
           hotelName = value.data['name'];
           hotelType = value.data['type'];
         });
       });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getUser();

  }



     
 

   Widget build(BuildContext context) {
    return Scaffold(
       
        floatingActionButton: FloatingActionButton(
         onPressed: (){
           Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddScreen(),));
         },
         child: Icon(
           Icons.add,
           color: Colors.white
         ),
         backgroundColor: Colors.blue,
       ),
       body:Container(
         padding: EdgeInsets.all(5.0),
         child: Card(
           child: ListTile(
             title: Text(hotelName),
             subtitle: Text(hotelType),
           ),
         ),
       )
    );
  }

  Widget menuList(){
    if(hotelinfo != null){
      return StreamBuilder(
        stream: hotelinfo,
        builder: (context,snapshot){
          return ListView.builder(
              padding: EdgeInsets.all(5.0),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context,i){
                return Card(
               child: ListTile(
                  title: Text(snapshot.data.documents[i].data['name']),
                  subtitle : Text(snapshot.data.documents[i].data['type']),
                                 
                ),
              );
              },
            );
        },
      );
    }
    else{
      return Text('Loading. Please Wait for a second.....');
    }
  }


} 