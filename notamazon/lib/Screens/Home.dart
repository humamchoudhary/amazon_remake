import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:notamazon/common/navigation_drawer.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notamazon/common/product_card.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DocumentReference itemsDoc =
      Firestore.instance.collection('Products').document("Categories");
  List<Widget> item_list = [];
  bool Loading = false;
  
  var username;
  
  String? email;
  
  String? img;
  Refresh() async {
    setState(() {
      Loading = true;
    });
    item_list.clear();
    GetData();
    setState(() {
      Loading = false;
    });
  }

  GetData() async {
    Loading = true;
    var user = await FirebaseAuth.instance.getUser();
    username = user.displayName;
    email = user.email;
    img = user.photoUrl;
    var snap = await itemsDoc.get();
    var data = snap.map;
    setState(() {
      item_list.clear(); 
      data.forEach((k, v) => item_list.add(ProductCard(
            name: k,
            price: "${v["price"]}",
            amount: "${v["amount"]}",
            image: v["image"],
            desc: "${v["desc"]}",
            rating: "${v["rating"]}",
            tags: v["tags"],
          )));
    });
    Loading = false;
  }

  AddItem() async {
    Loading = true;
    await itemsDoc.update({
      "item178": {
        "amount": 10,
        "price": 100,
        "desc": "hello",
        "image":
            "https://handymanappbackend.herokuapp.com/getimages?img=test.jpg",
        "rating": 4.5,
        "tags": ["test", "test2"]
      }
    });
    // Refresh();
    Loading = false;
  }

  CheckUpdates() async {
  }

  @override
  void initState() {
    GetData();
    super.initState();
    CheckUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(username:"$username",email:"$email", img: "$img",),

      floatingActionButton: FloatingActionButton(
        onPressed: () => {AddItem()},
        child: Icon(Icons.add),
      ),
      appBar: AppBar(title: Text("Home"), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async {
          Refresh();
        },
        child: ModalProgressHUD(
          inAsyncCall: Loading,
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ResponsiveGridList(
                  horizontalGridMargin: 16,
                  verticalGridMargin: 16,
                  minItemWidth: 150,
                  children: item_list),
            ),
          ),
        ),
      ),
    );
  }
}
