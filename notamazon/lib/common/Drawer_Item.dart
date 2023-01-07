import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key, required this.name, required this.icon, required this.onPressed});
  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Color.fromARGB(103, 255, 255, 255),
      focusColor: Color.fromARGB(103, 255, 255, 255),
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
        child: SizedBox(
          height: 40,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                Icon(icon,color: Colors.white,size: 22,),
                const SizedBox(width: 20,),
                Text(name,style: const TextStyle(color: Colors.white,fontSize: 16),)
          ]),
        ), 
      ),
    );
  }
}