import 'package:auto_size_text/auto_size_text.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatefulWidget {
  Details(
      {super.key,
      required this.prod_name,
      required this.desc,
      required this.img,
      required this.price,
      required this.rating,
      required this.amount,
      required this.tags});
  final String prod_name;
  final String desc;
  final String img;
  final String price;
  final String rating;
  final String amount;
  final List tags;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool Loading = false;
  DocumentReference itemsDoc =
      Firestore.instance.collection('Products').document("Categories");

  GetData() async {
    setState(() {
      Loading = true;
    });
    var inst = Firestore.instance;
    CollectionReference cat = inst.collection('Products');
    var snap = await itemsDoc.get();
    var data = snap.map;
    if (this.mounted) {
      setState(() {
        //   var prod = data["${widget.prod_name}"];
        //   desc   = prod.toString();
        //   // img    = prod["image"];
        //   // price  = "${prod["price"]}";
        //   // rating = "${prod["rating"]}";
        //   // amount = "${prod["amount"]}";
        //   // tags   = prod["tags"];
        //   // Loading = false;
        // print(prod);
        // print(desc);
        // print(img);
        // print(price);
        // print(amount);
        // print(prod);
        // Your state change code goes here
      });
    }
  }

  @override
  void initState() {
    // GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: Text("Details"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Ink.image(
                        image: NetworkImage("${widget.img}"),
                        height: (MediaQuery.of(context).size.height / 2) - 50,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${widget.prod_name}",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          letterSpacing: .75,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Price: ${widget.price} Rs",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            letterSpacing: .75,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Items Left: ${widget.amount}",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            letterSpacing: .75,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Description: ",
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            letterSpacing: .75,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  AutoSizeText("${widget.desc}",
                      overflow: TextOverflow.fade,
                      maxLines: 15,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            color: Colors.white,
                            letterSpacing: .5,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  // Row(children:[for (var i in widget.tags)  Text("$i", style: GoogleFonts.roboto(
                  //   textStyle: const TextStyle(
                  //       color: Colors.white,
                  //       letterSpacing: .5,
                  //       fontSize: 14,
                  //       fontWeight: FontWeight.bold),
                  // )),])
                ])),
      ),
    );
  }
}
