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
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Partner App'),
        centerTitle: true,
        actions: <Widget>[
           IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: (){
              signOut();
            },   
          )
         ],
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





    /*Scaffold(
      backgroundColor: Colors.blueAccent,
      
       body: Stack(
         children: <Widget>[
           Positioned(
              child: AppBar(
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text("Delivery Partner", style: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat')),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: (){
                    signOut();
                  },   
                )
              ],
               bottom: TabBar(
                controller: tabController,
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.home),),
                  Tab(icon: Icon(Icons.fastfood))
                ],
              ),
            ),
           ),
           
            SizedBox(height: 50),
              Positioned(
                top: 80.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  height: MediaQuery.of(context).size.height - 50.0,
                  width: MediaQuery.of(context).size.width,
                )
              ),
            Positioned(
             top: 120.0,
             child: TabBarView(
                controller: tabController,
                children: <Widget>[
                  first.HomePage(),
                  second.FoodScreen()
                ],
              ),
           ),
         ],
       )
    );*/