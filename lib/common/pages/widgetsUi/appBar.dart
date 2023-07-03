import 'package:financhio/Theme/pallete.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String url;
  final Function()? onTap;
  final Function()? onMonthTap;

  const MyAppBar({Key? key, required this.url, this.onTap, this.onMonthTap})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10.0),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 42,
            width: 42,
            child: CircleAvatar(
              
              backgroundColor: Colors.black,
              backgroundImage: NetworkImage(url),
            ),
          ),
        ),
      ),
      title: Container(
        height: 40,
        width: 107,
        decoration: BoxDecoration(
          border: Border.all(color: Pallete.purpleColor, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:2.0),
              child: GestureDetector(
                onTap: onMonthTap,
                child: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Pallete.purpleColor,
                  size: 24,
                ),
              ),
            ),
            SizedBox(width: 2),
            Text(
              'July',
              style: TextStyle(color: Pallete.backgroundColor, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

