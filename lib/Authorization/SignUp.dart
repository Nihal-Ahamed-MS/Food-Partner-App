import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'SignIn.dart';
import 'package:deliveryapp/Screen/HomePage.dart';
import 'package:deliveryapp/Screen/Home.dart';


class SignUp extends StatefulWidget {
  @override
   _SignUpState createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;
  GlobalKey <FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _pass;

  checkingAuth() async {
    firebaseAuth.onAuthStateChanged.listen(
      (user){
        if(user != null){
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));
      }
      }
    );
  }

  navigateToSignin(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SignIn()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkingAuth();
    
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

  signup()async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      try{
        FirebaseUser user = (await firebaseAuth.createUserWithEmailAndPassword(email: _email, password: _pass)).user;
        if(user!=null){
          UserUpdateInfo userUpdateInfo = UserUpdateInfo();
          userUpdateInfo.displayName = _name;
          user.updateProfile(userUpdateInfo);
        }
      }catch(e){
        showError(e.message);
      }
    }
  }


   @override
   Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Sign Up"),
       ),
       body: Container(
         child: Center(
           child: ListView(
             children: <Widget>[
              Container(
                 padding: EdgeInsets.all(50.0),
                 child: Form(
                   key: _formKey,
                   child: Column(
                     children: <Widget>[
                       Container(
                         padding: EdgeInsets.only(top:20.0),
                         child: TextFormField(
                           validator: (input){
                             if(input.isEmpty)
                             {
                               return "Provide an NAME";
                             }
                           },
                           decoration: InputDecoration(
                             labelText: 'Name',
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(5.0),
                              
                             )
                           ),
                           onSaved: (input) => _name = input,
                         ),
                       ),
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
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: RaisedButton(
                          
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)
                          )                          ,
                          onPressed: signup,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 20.0, color: Colors.white)
                          ),
                        ),
                       ),
                       GestureDetector(
                         onTap: navigateToSignin,
                         child: Text("Already having an account?",
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