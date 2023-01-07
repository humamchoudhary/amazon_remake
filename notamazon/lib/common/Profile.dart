// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notamazon/main.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.username, required this.img});
  final String img;
  final String username;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final dp = "https://minimaltoolkit.com/images/randomdata/male/107.jpg";
  File? image;
  String? path;
  String? img;
  String? username;
  String? email;
  bool delAccount = false;
  bool Loading = false;

  setUsername() async {
    try {
      await FirebaseAuth.instance.updateProfile(displayName: username);
      var user = await FirebaseAuth.instance.getUser();
      setState(() {
        username = user.displayName;
      });
      print(user.displayName);

    } catch (e) {
      print(e);
    }
  }

  loadDetails() async {
    setState(() {
      Loading = true;
    });
    // final response = await http.post(Uri.parse("$URL/account"),body: json.encode({"username":widget.username}));
    // final decode= json.decode(response.body) as Map<String,dynamic>;
    var user = await FirebaseAuth.instance.getUser();
    setState(() {
      img = user.photoUrl;
      username = user.displayName;
      // name = decode["name"];
      email = user.email;
      // ph = decode["ph_num"];
      // print(img);
      // print(decode);
    });
    setState(() {
      Loading = false;
    });
  }

  uploadImage() async {
    setState(() {
      Loading = true;
    });
    try {
      String fileName = path!.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(path!, filename: fileName),
      });
      var response = await Dio().post("http://127.0.0.1:5000/uploadimage", data: formData);
      print(fileName);
      // var images = Firestore.instance.reference("images");
      await FirebaseAuth.instance.updateProfile(photoUrl: "http://127.0.0.1:5000/getimages?img=$fileName");
      loadDetails();
    } catch (e) {
      print(e);
    }
    setState(() {
      Loading = false;
    });
  }

  Future getImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          this.image = File(pickedFile.path);
          path = pickedFile.path;
        });
        uploadImage();
      } else {
        print('no image selected');
      }
    } on PlatformException catch (e) {
      print('failed to pick: $e');
    }
  }

  @override
  void initState() {
    loadDetails();
    super.initState();
  }
CheckUsername(){
  return widget.username == "null"
                    ? _buildUserNameField()
                    : Text(
                        "@${widget.username}",
                        style: GoogleFonts.getFont('Noto Sans',
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 219, 219, 219),
                                fontSize: 14,
                                letterSpacing: 1)),
                      );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.purple,
      body: ModalProgressHUD(
        inAsyncCall: Loading,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 8, 30.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                widget.img == "null"
                    ? ProfileHeader(
                        "https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png")
                    : ProfileHeader("${widget.img}"),
                SizedBox(
                  height: 40,
                ),
                widget.username == "null"
                    ? _buildUserNameField()
                    : Text(
                        "@${widget.username}",
                        style: GoogleFonts.getFont('Noto Sans',
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 219, 219, 219),
                                fontSize: 14,
                                letterSpacing: 1)),
                      ),
                
                SizedBox(
                  height: 5,
                ),
                Text("$email",
                    style: GoogleFonts.getFont(
                      'Noto Sans',
                      textStyle: TextStyle(
                          color: Color.fromARGB(255, 172, 172, 172),
                          fontSize: 14,
                          letterSpacing: 1),
                    )),
                SizedBox(
                  height: 50,
                ),
                Divider(thickness: 1, height: 20, color: Colors.white),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          delAccount = true;
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                            Text("Delete account",
                                style: GoogleFonts.getFont('Noto Sans',
                                    textStyle: TextStyle(
                                        color: Colors.black, fontSize: 16)))
                          ])),
                ),
                if (delAccount == true)
                  AlertDialog(
                    title: Row(
                      children: [
                        Icon(Icons.warning),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Are you Sure?",
                            style: GoogleFonts.getFont('Noto Sans',
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1))),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text("Yes"),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                      ),
                      TextButton(
                        child: Text("No"),
                        onPressed: () {
                          setState(() {
                            delAccount = false;
                          });
                        },
                      ),
                    ],
                    content: Text(
                        "Are you tring to delete your account! This cant be undone"),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildUserNameField() {
    return Form(
      key: _formkey,
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: (MediaQuery.of(context).size.width / 2),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "Username", focusColor: Colors.white),
                style: TextStyle(color: Colors.white),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Username is required';
                  }
                },
                onSaved: (String? value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  print("adding usernme");
                  setState(() {
                    Loading = true;
                  });
                  _formkey.currentState!.save();
                  await setUsername();
                  setState(() {
                    Loading = false;
                  });
                },
                child: Text("Update"))
          ]),
    );
  }

  Widget ProfileHeader(String img) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(img),
        ),
        // InkWell(
        //   onTap: () => {getImage()},
        //   child:CircleAvatar(
        //   backgroundColor: Colors.black,
        //   child: TextButton(
        //       onPressed:null,
        //       child:  Icon(
        //             Icons.add_a_photo,
        //             color: Colors.white,
        //           )),),
        // ),
        IconButton(
          onPressed: () => getImage(),
          icon: Icon(Icons.add_a_photo),
          color: Colors.white,
        )
      ],
    );
  }
}
