import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryapp/services/HotelManagement.dart';


class FoodEditScreen extends StatefulWidget {

final docId;

FoodEditScreen({this.docId});

  @override
   _FoodEditScreenState createState() => _FoodEditScreenState();
}
class _FoodEditScreenState extends State<FoodEditScreen> {

bool onOff = true;


   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
   FirebaseUser user;
   String _uid;
   Stream hotemenu;

   HotelManagement hotelManagement = HotelManagement();

   bool avail;

 void getAvailability(){
   Firestore.instance.collection('HotelManagement')
              .document(_uid)
              .collection('HotelMenu')
              .document(widget.docId)
              .get().then((value) {

                setState(() {
                  onOff = value.data['availability'];
                });
  
              });
 }


     getUser() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await firebaseAuth.currentUser();

    if(firebaseUser!=null){
      setState(() {
        this.user = firebaseUser;
        this._uid = firebaseUser.uid;
        this.getAvailability();
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
         title: Text("Edit Food"),
       ),
       body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Text('Availability'),
          Switch(
                   value: onOff,
                   onChanged: (bool newValue) {
                    setState(() {
                    onOff = newValue;
                     });
                     hotelManagement.updateData(user, widget.docId, {
                       'availability': newValue
                     });
                    },
                 ),
        ],)
       ),
    );
  }
} 