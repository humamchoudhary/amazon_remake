import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? _email = "";
  String? _password = "";
  String _error = "";
  bool LoadingData = false;
  double _finalwidth = 0;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController passwordcont = TextEditingController();
  
  String? _username;

Future<void> _save()async{
    _formkey.currentState!.save();
    await signup();

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
  Widget _buildUsernameField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Username"
      ),
        validator: (String? value){
          if(value!.isEmpty){
            return 'Username is required';
          }
        },
        onSaved: (String? value){
          setState(() {
            
          _username = value;
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
      controller: passwordcont,
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
   Widget _buildPasswordConfField(){
    return  TextFormField(
      decoration: InputDecoration(
        labelText: "Password confirmation"
      ),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
enableSuggestions: false,
autocorrect: false,
        validator: (String? value){
          if(value!.isEmpty){
            return 'Password is required';
          }
          if(value==passwordcont.value){
            return 'Password doesnot match';
          }
        },
        
    );
  }
  @override
  Widget build(BuildContext context) {
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
          title:Text("Sign Up"),
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
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SizedBox(
                    width: _finalwidth,
                    child:_buildUsernameField(),
                    )
                    ],
                    ),
                    SizedBox(height: 10,),
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
                    SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [SizedBox(
                    width: _finalwidth,
                    child:_buildPasswordConfField(),
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
                    child:Text('Sign Up'),
                      
                      ),

                    onPressed:()async { 
                      await _save();
                       } , 
                    ),
                    SizedBox(height: 15),
                  
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
  
  signup()async{

    try{
      setState(() {
        LoadingData = true;
      });

  // await FirebaseAuth.instance.signIn(_email!, _password!);
    await FirebaseAuth.instance.signUp("$_email","$_password");
    var user = await FirebaseAuth.instance.getUser();
    FirebaseAuth.instance.updateProfile(displayName: _username,photoUrl: "https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png");

    print(user.displayName);
        setState(() {
        LoadingData = true;
      });
  Navigator.restorablePushReplacementNamed(context, "/auth");
    }catch(e){
      setState(() {
        _error = "$e";
        LoadingData = false;
      });
    }

  
  }
}