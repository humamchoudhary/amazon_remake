import 'package:firedart/firedart.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:notamazon/Services/Auth.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return LoginScreenstate();
  }
}

class LoginScreenstate extends State<Login>{

  String? _email = "";
  String? _password = "";
  String _error = "";
  bool LoadingData = false;
  
  // TextEditingController emailcontrol
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  login()async{
    try{
      setState(() {
        LoadingData = true;
      });

  await FirebaseAuth.instance.signIn(_email!, _password!);
  var user = await FirebaseAuth.instance.getUser();
        
      setState(() {
                      AUTH =true;
                      // print(auth);
                      });
  Navigator.pushReplacementNamed(context, "/auth");
    }catch(e){
      setState(() {
        _error = "$e";
        LoadingData = false;
      });
    }

  }
  
  Widget _buildEmailField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email"
      ),
        validator: (String? value){
          if(value!.isEmpty){
            return 'Email is required';
          }
        },
        onSaved: (String? value){
          setState(() {
            
          _email = value;
          });
        },
    );
  }
  Widget _buildPasswordField(){
    return  TextFormField(
      decoration: InputDecoration(
        labelText: "Password"
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
enableSuggestions: false,
autocorrect: false,
        validator: (String? value){
          if(value!.isEmpty){
            return 'Password is required';
          }
        },
        onSaved: (String? value){
          setState(() {
          _password = value;
          });
        },
    );
  }
  Future<void> _save()async{
    _formkey.currentState!.save();
  }
  double _finalwidth = 0;


  @override
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;

  // print(screenWidth);
  if(screenWidth <= 450){
    setState(() {
      _finalwidth = screenWidth - 50;
    });
  }
  else{
    setState(() {
      _finalwidth = 430;

    });
  };
     
    return Scaffold(
        appBar: AppBar(
          title:Text("Not Amazon"),
          centerTitle: true,
          
      ),
          body: ModalProgressHUD(
                        inAsyncCall: LoadingData,
                      child:SingleChildScrollView
          (child: Padding(
      padding: const EdgeInsets.only(left:10,right: 10,top: 100),
      child: 
          Center(
            child: Container(
              child: Form(
                key: _formkey,
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(_error,style: TextStyle(color: Colors.red)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SizedBox(
                    width: _finalwidth,
                    child:_buildEmailField(),
                    )
                    ],
                    ),
                    SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SizedBox(
                    width: _finalwidth,
                    child:_buildPasswordField(),
                    )
                    ],
                    ),
                  
                  // _buildPasswordField(),
                  SizedBox(
                    height: 100,
                  ),
                  ElevatedButton(
                    child: Padding(
  	                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                    child:Text('Login'),
                      
                      ),

                    onPressed:()async { 
                      _save();
                      await login();
                      
                       } , 
                    ),
                    SizedBox(height: 15),
                  TextButton(
                    child: Text("SignUp",key:ValueKey("signup")),
                    onPressed: () {
                      // print(ValueKey("signup"));
                      Navigator.pushNamed(context, '/signup');
                    },
                  )
                ]
                ),
                )
            ),
          ),
          
      )
      ),
      )
      );
  } 
}