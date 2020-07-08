import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'SignUp.dart';
import 'package:deliveryapp/Screen/HomePage.dart';
import 'package:deliveryapp/Screen/Home.dart';

class SignIn extends StatefulWidget {
  @override
   _SignInState createState() => _SignInState();
}
class _SignInState extends State<SignIn> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  String _email, _pass;

  checkAuth(){
    _auth.onAuthStateChanged.listen((user) async {
      if(user != null){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));
      }
    });
  }

  navigaToSignup(){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignUp()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAuth();
  }

  void signIn() async {
    if(_form.currentState.validate()){
      _form.currentState.save();
    try{
      FirebaseUser user = ( await _auth.signInWithEmailAndPassword(email: _email, password: _pass)).user;
    }
    catch (e){
      showError(e.message);
    }

    }

   
  }

  showError(String error){
    showDialog(context: context,
      builder: (BuildContext){
        return AlertDialog(
          title: Text("Error"),
          content: Text(error),
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text("OK"))
          ],
        );
      }
    );
  }

   @override
   Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Sign In"),
       ),
       body: Container(
         child: Center(
           child: ListView(
             children: <Widget>[
               
               Container(
                 padding: EdgeInsets.all(50.0),
                 child: Form(
                   key: _form,
                   child: Column(
                     children: <Widget>[
                       Container(
                         padding: EdgeInsets.only(top:20.0),
                         child: TextFormField(
                           validator: (input){
                             if(input.isEmpty)
                             {
                               return "Provide an email";
                             }
                           },
                           decoration: InputDecoration(
                             labelText: 'Email',
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5.0),
                              
                             )
                           ),
                           onSaved: (input) => _email = input,
                         ),
                       ),
                        Container(
                         padding: EdgeInsets.only(top:20.0),
                         child: TextFormField(
                           validator: (input){
                             if(input.length < 6)
                             {
                               return "6 character is must";
                             }
                           },
                           decoration: InputDecoration(
                             labelText: 'Password',
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5.0),
                              
                             )
                           ),
                           onSaved: (input) => _pass = input,
                           obscureText: true,
                         ),
                       ),
                       Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                        child: RaisedButton(
                          
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                          )                          ,
                          onPressed: signIn,
                          child: Text(
                            "Sign In",
                            style: TextStyle(fontSize: 20.0, color: Colors.white)
                          ),
                        ),
                       ),
                       GestureDetector(
                         onTap: navigaToSignup,
                         child: Text("Create an account",
                         textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20.0),
                        )
                       ),
                     ],
                   ),
                 ) 
               )
             ],
           ),
         ),
       ),
    );
  }
} 