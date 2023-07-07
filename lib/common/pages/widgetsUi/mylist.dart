// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financhio/common/pages/widgetsUi/infoTra.dart';
import 'package:financhio/common/widegets/loading.dart';
import 'package:financhio/features/trasactionpages/controller/addtransactionController.dart';
import 'package:financhio/models/transaction.dart';
import 'package:flutter/material.dart';

import 'package:financhio/Theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TransactionListView extends ConsumerWidget {

  final String period;
  final String bankName;
 final ScrollController scrollController;

  TransactionListView( this.period, this.bankName, this.scrollController);
  
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return 
       StreamBuilder<List<TransactionModel>>(
         stream: ref.watch(addTransactionProvider).QueryListGen(period, bankName),
         builder: (context,snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Loader();
          }
           return ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: scrollController,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
            var trasactionData=snapshot.data![index];
           
             String url="https://source.unsplash.com/user/wsanter";
             String amount=trasactionData.amount.toString();
             String type=trasactionData.type;
             String category=trasactionData.category;
             String datetime=trasactionData.datetime;
             String description=trasactionData.description!;
             String tuid=trasactionData.tuid;
              return MyListCard(url: url,amount: amount,category: category,type: type,datetime: datetime,description: description,attachment: trasactionData.attachment,tuid:tuid,bankName: bankName,);
            },
      
    );
         }
       );
  }
}
class MyListCard extends StatelessWidget {
  final String url;
  final String amount;
  final String type;
  final String category;
  final String datetime;
  final String description;
  final String? attachment;
  final String tuid;
  final String bankName;

  // Map associating each category with its color and asset image
  static const Map<String, Color> categoryColors = {
    'Shopping': Color.fromARGB(255, 255, 255, 255),
    'Food': Color.fromARGB(255, 255, 233, 253),
    'Job': Color.fromARGB(255, 203, 253, 238),
    'Fees':Color.fromARGB(255, 224, 246, 255),
    'Others':Color.fromARGB(255, 211, 190, 255),
    'Startup':Color.fromARGB(255, 229, 246, 255),
    'Technology':Color.fromARGB(255, 255, 217, 206)
  };

  static const Map<String, String> categoryImages = {
    'Shopping': 'assets/images/shopping bag.png',
    'Food': 'assets/images/food.png',
    'Job': 'assets/images/success.png',
    'Fees':"assets/images/wallet 3.png",
    'Others':"assets/images/Frame 5.png",
    
    'Startup':"assets/images/Frame 5.png",
    'Technology':"assets/images/subsc.png",
    "Tutorials":"assets/images/Frame 5.png",
    "Skills":"assets/images/subsc.png",
  };

  const MyListCard({
    Key? key,
    required this.url,
    required this.amount,
    required this.type,
    required this.category,
    required this.datetime,
    required this.description,
    required this.tuid,
    this.attachment,
    required this.bankName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime datetimei = DateFormat("yyyy-MM-dd HH:mm:ss.SSSSSS").parse(datetime);
    String formattedDatetime = DateFormat.yMd().add_jm().format(datetimei);

    Color categoryColor = categoryColors.containsKey(category)
        ? categoryColors[category]!
        : Colors.black; // Default color if category is not found in the map

    String categoryImage = categoryImages.containsKey(category)
        ? categoryImages[category]!
        : ''; // Default image if category is not found in the map

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return TransactionInfo(
                transaction: TransactionModel(
                  amount: double.parse(amount),
                  datetime: datetime,
                  type: type,
                  category: category,
                  bankName: bankName,
                  description: description,
                  attachment: attachment,
                  tuid: tuid,
                ),
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
        child: Container(
          height: 89,
          width: 320,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 248, 248, 255),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: url.isNotEmpty
                            ? Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: categoryColor,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: AssetImage(categoryImage),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            : Icon(Icons.wallet_outlined, color: Pallete.blueColor),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child: Text(
                            category,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Pallete.backgroundColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          child: Container(
                            width: 120,
                            child: Text(
                              description,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Pallete.greyColor,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
                    child: Text(
                      type == 'Expense' ? "- $amount" : "+ $amount",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: type == 'Expense' ? Pallete.redColor : Pallete.greenColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    child: Text(
                      formattedDatetime,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Pallete.greyColor,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
