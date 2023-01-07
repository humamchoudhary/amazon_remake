import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:notamazon/Screens/item_details.dart';
import 'reponisvelayout.dart';

class ProductCard extends StatefulWidget {
  final String price;
  final String amount;
  final String image;
  final String name;
  final String desc;
  final List tags;
  final String rating;

  const ProductCard(
      {required this.name,
      required this.price,
      required this.amount,
      required this.image, required this.desc, required this.tags, required this.rating});
  _ProdCardState createState() => _ProdCardState();
}

class _ProdCardState extends State<ProductCard> {
  Widget _buildCard(img, name, price, amount) {
    final screenWidth = MediaQuery.of(context).size.width;

    double cardsize = (screenWidth / 2) - 20;
    if (cardsize >= 150) {
      cardsize = 150;
    }

    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 400),
      transitionType: ContainerTransitionType.fadeThrough,
      openColor: Colors.purple,
      closedColor: Colors.white,
      openBuilder: (context, action)  {return Details(prod_name:widget.name, amount: widget.amount, desc: widget.desc, img: widget.image, price: widget.price, rating: widget.rating, tags: widget.tags,);},
      closedBuilder:(context,action) {return SizedBox(
          width: 150,
          height: 250,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
              color: Colors.black12,
              child: Ink.image(
                image: NetworkImage(img),
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                child: InkWell(
                  onTap: (() {}),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: ResponsiveLayout(
                desktopBody: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("$price RS", style: TextStyle(fontSize: 12)),
                        Text("$amount items left", style: TextStyle(fontSize: 12))
                      ],
                    ),
                  ],
                ),
                mobileBody: Column(
                  children: [
                    Text(name,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("$price RS", style: TextStyle(fontSize: 12)),
                        Text("$amount items left", style: TextStyle(fontSize: 12))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]));}
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCard(widget.image, widget.name, widget.price, widget.amount);
  }
}
