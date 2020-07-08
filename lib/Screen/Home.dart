import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:deliveryapp/Authorization/SignIn.dart';
import 'HomePage.dart' as first;
import 'FoodScreen.dart' as second;

class Home extends StatefulWidget {
  @override
   _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
   FirebaseUser user;

   TabController tabController;

   

  checkAuthState(){
    firebaseAuth.onAuthStateChanged.listen((user) async {
      if(user == null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SignIn(),));
      }

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.checkAuthState();
    this.tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    this.tabController.dispose();
  }

   signOut() async {
    firebaseAuth.signOut();
    SystemNavigator.pop();
  }

   @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partner App'),
        actions: <Widget>[
           IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              signOut();
            },   
          )
         ],
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.home),),
            Tab(icon: Icon(Icons.fastfood))
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          first.HomePage(),
          second.FoodScreen()
        ],
      ),
    );
  }
} 