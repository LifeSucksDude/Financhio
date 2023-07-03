import 'package:flutter/material.dart';

import '../../Theme/pallete.dart';
import 'widgetsUi/mylist.dart';
import 'widgetsUi/slectable.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
   String selectedValue = '0';
   List items=[];
    void updateSelectedValue(String value) {
    setState(() {
      selectedValue = value;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              children: [
          SizedBox(height: 20),
          Center(
              child: Text(
            "Account Balance",
            style: TextStyle(color: Colors.black54, fontSize: 14),
          )),
          SizedBox(
            height: 4,
          ),
          //add Balance
          Text(
            "Rs.56000",
            style: TextStyle(
                fontSize: 40, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 80,
                  //   width: 164,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Pallete.greenColor),
                  child: Center(
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: Pallete.whiteColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.monetization_on,
                            color: Pallete.greenColor,
                            size: 32,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Income",
                            style: TextStyle(
                                color: Pallete.whiteColor, fontSize: 14),
                          ),
                          // SizedBox(height: 8,),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              "Rs.20,000",
                              style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Container(
                  height: 80,
                  //  width: 164,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Pallete.redColor),
                  child: Center(
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: Pallete.whiteColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.money_off,
                            color: Pallete.redColor,
                            size: 32,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Expense",
                            style: TextStyle(
                                color: Pallete.whiteColor, fontSize: 14),
                          ),
                          // SizedBox(height: 8,),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              "Rs.20,000",
                              style: TextStyle(
                                  color: Pallete.whiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          )
                        ],
                      )
                    ]),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
        
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Spending Analytics",
                  style: TextStyle(
                      fontSize: 18,
                      color: Pallete.backgroundColor,
                      fontWeight: FontWeight.w600),
                )),
          ),
          //MakePlotterThatTakesBalanceAndTime,
               Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
          SelectableItem(
            label: 'Day',
            isSelected: selectedValue == 'Day',
            onTap: () {
              updateSelectedValue('Day');
            },
          ),
          SelectableItem(
            label: 'Week',
            isSelected: selectedValue == 'Week',
            onTap: () {
              updateSelectedValue('Week');
            },
          ),
          SelectableItem(
            label: 'Month',
            isSelected: selectedValue == 'Month',
            onTap: () {
              updateSelectedValue('Month');
            },
          ),
          SelectableItem(
            label: 'Year',
            isSelected: selectedValue == 'Year',
            onTap: () {
              updateSelectedValue('Year');
            },
          ),
          //Make The Plot Here,
          TransationListView(element: items,),
              ],
            )
              ],
            ),
        ));
  }
}
