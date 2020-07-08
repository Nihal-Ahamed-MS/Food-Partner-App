import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'FoodEditScreen.dart';
import 'package:deliveryapp/services/HotelManagement.dart';

class FoodScreen extends StatefulWidget {
  @override
   _FoodScreenState createState() => _FoodScreenState();
}
class _FoodScreenState extends State<FoodScreen> {
   @override
  
   String foodName;
   String price;
   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
   FirebaseUser user;
   String _uid;
   Stream hoteinfo;

   HotelManagement hotelManagement = HotelManagement();


     getUser() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    await firebaseUser?.reload();
    firebaseUser = await firebaseAuth.currentUser();

    if(firebaseUser!=null){
      setState(() {
        this.user = firebaseUser;
        this._uid = firebaseUser.uid;
        menuDetails();
      });
    }
  }

  void menuDetails(){
    hotelManagement.getData(_uid,'HotelMenu').then((result){
      setState(() {
        hoteinfo = result;
      });
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getUser();

  }

    
     
   Future<bool> addDialog(BuildContext context) async{
     return showDialog(
       context: context,
       barrierDismissible: false,
       builder: (BuildContext context){
         return AlertDialog(
           title: Text('Add Food Items', style: TextStyle(fontSize: 15.0)),
           content: Container(
             height: 200.0,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 TextFormField(
                   decoration: InputDecoration(hintText: 'Enter Food Name'),
                   onChanged: (value){
                     this.foodName = value;
                   },
                 ),
                 SizedBox(height: 5.0,),
                 TextFormField(
                   decoration: InputDecoration(hintText: 'Enter Price'),
                   onChanged: (value){
                     this.price = value;
                   },
                 ),
                 SizedBox(height: 5.0,),
                 
               ],
             ),
           ),
           actions: <Widget>[
             FlatButton(
               child: Text('Add'),
               textColor: Colors.blue,
               onPressed: (){
                 Navigator.of(context).pop();
                 HotelManagement().hotelMenu(user, foodName, price);
               },
             )
           ],
         );
       }
     );
   }

  
   Future<bool> updateDialog(BuildContext context,String name, String price) async{
 bool onOff=false;
     TextEditingController nameController = TextEditingController();
     TextEditingController priceController = TextEditingController();

     nameController.text = name;
     priceController.text = price;

     return showDialog(
       context: context,
       barrierDismissible: false,
       builder: (BuildContext context){
         return AlertDialog(
           title: Text('Update', style: TextStyle(fontSize: 15.0)),
           content: Container(
             height: 300.0,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 TextFormField(
                   controller: nameController,
                   decoration: InputDecoration(hintText: 'Enter Food Name'),
                   onChanged: (value){
                     print(value);
                     this.foodName = value;
                   },
                 ),
                 SizedBox(height: 5.0,),
                 TextFormField(
                   controller: priceController,
                   decoration: InputDecoration(hintText: 'Enter Price'),
                   onChanged: (value){
                     this.price = value;
                   },
                 ),
                 
               ],
             ),
           ),
           actions: <Widget>[
             FlatButton(
               child: Text('Add'),
               textColor: Colors.blue,
               onPressed: (){
                 Navigator.of(context).pop();
                 HotelManagement().hotelMenu(user, foodName, price);
               },
             )
           ],
         );
       }
     );
   }

   Widget build(BuildContext context) {
    return Scaffold(
       
        floatingActionButton: FloatingActionButton(
         onPressed: (){
           addDialog(context);
         },
         child: Icon(
           Icons.add,
           color: Colors.white
         ),
         backgroundColor: Colors.blue,
       ),
       body: menuList()
    );
  }

  Widget menuList(){
    if(hoteinfo != null){
      return StreamBuilder(
        stream: hoteinfo,
        builder: (context,snapshot){
          return ListView.builder(
              padding: EdgeInsets.all(5.0),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context,i){
                return Card(
               child: ListTile(
                  title: Text(snapshot.data.documents[i].data['food']),
                  subtitle : Text(snapshot.data.documents[i].data['price']),
                  onLongPress: (){
                    hotelManagement.deletData(user, snapshot.data.documents[i].documentID);
                  },
                
                 onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context) => FoodEditScreen(docId: snapshot.data.documents[i].documentID),));
                 },
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



/*Switch(
                   value: onOff,
                   onChanged: (bool newValue) {
                    setState(() {
                    onOff = newValue;
                     });
                    },
                 ),*/