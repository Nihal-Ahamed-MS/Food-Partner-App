import 'package:flutter/material.dart';
import 'Screen/FoodScreen.dart';
import 'Authorization/SignIn.dart';
import 'Screen/Home.dart';
import 'Screen/HomePage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Firebase Login",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}


class MyBottomNavigationBar extends StatefulWidget {
  @override
   _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}
class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
 int selectedItemIndex = 0;
  final screens = [
    HomePage(),
    FoodScreen()
  ];
   Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        children: <Widget>[
          buildBottomNavigator(Icons.home,0),
          buildBottomNavigator(Icons.fastfood,1),
        ],
      ),
       body: screens[selectedItemIndex]
    );
  }

   Widget buildBottomNavigator(IconData icon,int index) {
     return GestureDetector(
       onTap: (){
         setState(() {
           selectedItemIndex = index;
         });
       },
            child: Container(
            height: 60,
            width: MediaQuery.of(context).size.width/4,
            decoration: index == selectedItemIndex ? BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 4, color: Colors.blue)
              ),
              gradient: LinearGradient(colors: [Colors.blue.withOpacity(0.3),Colors.blue.withOpacity(0.015)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter
              ),
              color: index == selectedItemIndex ? Colors.blue : Colors.white
            ) : BoxDecoration(),
            child: Icon(icon, color: index == selectedItemIndex ? Colors.blue : Colors.grey,),
          ),
     );
   }

} 