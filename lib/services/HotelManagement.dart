import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/widgets.dart';
class HotelManagement{
        
    hoteBasicInfo(user,String type,String address,String phone,String name) async {

      await Firestore.instance.collection('HotelManagement').document(user.uid).setData({
        'email' : user.email,
        'name' : name,
        'uid': user.uid,
        'photoUrl' : user.photoUrl,
        'phone': phone,
        'address' : address,
        'type' : type
      }).then((value) => print('succesffully for hotelbasicinfo'))
      .catchError((e){
        print(e);
      });
    }

      hotelMenu(user,String foodName,String foodPrice/*,bool availability*/){
      Firestore.instance.collection('HotelManagement').document(user.uid).collection('HotelMenu').add({
        'food' : foodName,
        'price': foodPrice,
        'availability' : true
        //'availability' : availability,
        
      }).then((value) => print('succesffully for hoteMenu'))
      .catchError((e){
        print(e);
      });

      
    }

   

    
    getData(String user,String path) async{

      return await Firestore.instance.collection('HotelManagement').document(user).collection(path).snapshots();
    
    }

    updateData(user,selectedDoc,newValues){
       Firestore.instance.collection('HotelManagement').document(user.uid).collection('HotelMenu').document(selectedDoc).updateData(newValues).catchError((e){
         print(e);
       });
    }

    deletData(user,docId){
      Firestore.instance.collection('HotelManagement').document(user.uid).collection('HotelMenu').document(docId).delete().catchError((e){
        print(e);
      });
    }


    // Future <void> menu(user,String foodName,String foodPrice/*,bool availability*/){
    //   Firestore.instance.runTransaction((transaction) async{
    //     CollectionReference ref =  Firestore.instance.collection('hotelManagement').document(user.uid).collection('HotelMenu');

    //     ref.add(
    //       'foodName' : foodName
    //     );
    //   });
    // }
}