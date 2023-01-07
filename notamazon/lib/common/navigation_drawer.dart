import 'package:auto_size_text/auto_size_text.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import '../Services/Auth.dart';
import 'Drawer_Item.dart';
import 'Profile.dart';
import 'package:notamazon/main.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer(
      {super.key,
      required this.email,
      required this.username,
      required this.img});
  final String email;
  final String username;
  final String img;
  void ItemPressed(BuildContext context, {required int index}) {
    Navigator.pop(context);
    switch (index) {
      case 0:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Profile(username: username, img: img)));
        break;
      case 3:
        FirebaseAuth.instance.signOut();
        AUTH=false;
        Navigator.pushReplacementNamed(context, "/auth");
        break;

      default:
        Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.purple,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 24, 30),
          child: Column(children: [
            ProfileHeader(username, email, img),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerItem(
                name: "Account",
                icon: Icons.account_circle_rounded,
                onPressed: () => ItemPressed(context, index: 0)),
            
            const SizedBox(
              height: 10,
            ),
            DrawerItem(
                name: "Wishlist",
                icon: Icons.shopping_bag_outlined,
                onPressed: () => ItemPressed(context, index: 1)),
            const SizedBox(
              height: 10,
            ),
            DrawerItem(
                name: "Cart",
                icon: Icons.shopping_cart,
                onPressed: () => ItemPressed(context, index: 2)),
            const SizedBox(
              height: 40,
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerItem(
                name: "Logout",
                icon: Icons.logout,
                onPressed: () => ItemPressed(context, index: 3)),
            const SizedBox(
              height: 10,
            ),
            DrawerItem(
                name: "Delete Account",
                icon: Icons.delete,
                onPressed: () => ItemPressed(context, index: 1)),
            const SizedBox(
              height: 10,
            ),
          ]),
        ),
      ),
    );
  }
}

Widget ProfileHeader(String name, String email, String img) {
  // const dp = "https://minimaltoolkit.com/images/randomdata/male/107.jpg";
  return Row(
    children: [
      CircleAvatar(
        radius: 40,
         backgroundImage:img=="null" ? NetworkImage("https://www.pngitem.com/pimgs/m/30-307416_profile-icon-png-image-free-download-searchpng-employee.png"): NetworkImage("$img"),
      ),
      const SizedBox(
        width: 10,
      ),
      SizedBox(
        width: 170,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(
              height: 5,
            ),
            AutoSizeText(
              email,
              overflow: TextOverflow.ellipsis,
              minFontSize: 10,
              maxLines: 2,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      )
    ],
  );
}
