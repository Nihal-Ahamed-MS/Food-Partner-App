import 'package:cloud_firestore/cloud_firestore.dart';

class HotelManagement{

  Firestore ref = Firestore.instance;
        
    hoteBasicInfo(user,String type,String address,String phone,String name) async {

      await ref.collection('HotelManagement').document(user.uid).setData({
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

      hotelMenu(user,String foodName,String foodPrice) async{
        await ref.collection('HotelManagement').document(user.uid).collection('HotelMenu').add({
        'food' : foodName,
        'price': foodPrice,
        'availability' : true
        
      }).then((value) => print('succesffully for hoteMenu'))
      .catchError((e){
        print(e);
      });

      
    }

   

    
    getData(String user,String path) async{

      return await ref.collection('HotelManagement').document(user).collection(path).snapshots();
    
    }

    updateData(user,selectedDoc,newValues){
       ref.collection('HotelManagement').document(user.uid).collection('HotelMenu').document(selectedDoc).updateData(newValues).catchError((e){
         print(e);
       });
    }

    deletData(user,docId){
      ref.collection('HotelManagement').document(user.uid).collection('HotelMenu').document(docId).delete().catchError((e){
        print(e);
      });
    }


}