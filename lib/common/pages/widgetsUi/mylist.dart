// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:financhio/Theme/pallete.dart';

class TransationListView extends StatelessWidget {
  final List element;
   TransationListView({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: element.length,
      itemBuilder: (context, index) {
        return MyListCard();
      },
    );
  }
}
class MyListCard extends StatelessWidget {
  final String url;
  const MyListCard({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 4),
      child: Container(
        height: 89 ,
        width: 336,
        decoration: BoxDecoration(
          color: Pallete.whiteFadeColor,
          borderRadius: BorderRadius.circular(24),

        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Container(
            height: 60,
            width: 60,
             decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),

        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: url.isNotEmpty? Image.network(url):Icon(Icons.wallet_outlined,color: Pallete.blueColor,),
        ),
           )
          ],
        ),
      ),
    );
  }
}
