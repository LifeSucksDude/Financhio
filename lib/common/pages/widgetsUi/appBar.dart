import 'package:financhio/common/pages/profilepage.dart';
import 'package:flutter/material.dart';

import '../../../Theme/pallete.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String url;
  final String? selectedBank;
  final Function()? onTap;
  final Function()? onBankTap;

  const MyAppBar({Key? key, required this.url, this.onTap, required this.selectedBank, this.onBankTap})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Pallete.whiteColor,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return
          ProfilePage();
            }));
          },
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
      title: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: InkWell(
          onTap: onBankTap,
          child: Container(
            height: 40,
            width: 107,
            decoration: BoxDecoration(
              border: Border.all(color: Pallete.purpleColor, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    selectedBank ?? "select bank",
                    style: TextStyle(color: Pallete.backgroundColor, fontSize: 18, overflow: TextOverflow.ellipsis),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Pallete.purpleColor,
                  size: 24,
                ),
                SizedBox(width: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
