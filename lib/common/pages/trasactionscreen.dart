import 'package:financhio/Theme/pallete.dart';
import 'package:financhio/common/pages/mainScreen.dart';
import 'package:financhio/common/pages/widgetsUi/slectable.dart';
import 'package:financhio/common/widegets/loading.dart';
import 'package:financhio/features/trasactionpages/controller/addtransactionController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgetsUi/mylist.dart';


final filterProvider = StateProvider((ref) {
  return "Income";
});
final sortProvider = StateProvider((ref) {
  return "Highest";
});

class TransactionScreen extends ConsumerWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final bankNameFuture = ref.watch(mySelectedBankProvider);

    final filter = ref.watch(filterProvider);
    final sort = ref.watch(sortProvider);
    return Scaffold(
      body: FutureBuilder<String?>(
          future: bankNameFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader();
            }
            if(snapshot.data==null){
              return Center(child: Text("Please belect a Bank",style: TextStyle(fontSize:32,color: Pallete.greyColor),));
            }
            final bankName = snapshot.data;
            return StreamBuilder(
              stream: ref
                  .watch(addTransactionProvider)
                  .filterOutList(bankName!, filter, sort),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loader();
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var trasactionData = snapshot.data![index];
                                      
                            String url = "https://source.unsplash.com/user/wsanter";
                            String amount = trasactionData.amount.toString();
                            String type = trasactionData.type;
                            String category = trasactionData.category;
                            String datetime = trasactionData.datetime;
                            String description = trasactionData.description!;
                            String tuid=trasactionData.tuid;
                            String bankName=trasactionData.bankName;
                            return MyListCard(
                              url: url,
                              amount: amount,
                              category: category,
                              type: type,
                              datetime: datetime,
                              description: description,
                              tuid: tuid,
                              bankName: bankName,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomDrawer(context,ref);
        },
        child: Icon(Icons.filter_alt),
      ),
    );
  }
}

void _showBottomDrawer(
    BuildContext context,  WidgetRef ref) {
      
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        
        builder: (context, ref, child) {
         String filter=ref.watch(filterProvider);
         String sort=ref.watch(sortProvider);
          return
          Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color.fromARGB(255, 242, 249, 255)
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.5,
          // Add your desired content here
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(right:20.0),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.height/12,
                      height: 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color:Pallete.purpleColor
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Filter Transactions',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Pallete.backgroundColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 30.0),
                const Text(
                  'Filter by',
                  style: TextStyle(
                      fontSize: 20,
                      color: Pallete.backgroundColor,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectableItem(
                        label: "Income",
                        isSelected: filter == "Income",
                        onTap: () {
                          ref.read(filterProvider.notifier).update((state) => "Income");
                        }),
                   const SizedBox(width: 8,),
                    SelectableItem(
                        label: "Expense",
                        isSelected: filter == "Expense",
                        onTap: () {
                           ref.read(filterProvider.notifier).update((state) => "Expense");
                        }),
                           const SizedBox(width: 8,),
                    SelectableItem(
                        label: "All", isSelected: filter == "All", onTap: () {
                           ref.read(filterProvider.notifier).update((state) => "All");
                        })
                  ],
                ),
                SizedBox(height: 40,),
                Text("Sort By",style: TextStyle(fontSize: 
                20,fontWeight: FontWeight.w600),),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SelectableItem(
                        label: "Highest",
                        isSelected: sort == "Highest",
                        onTap: () {
                          ref.read(sortProvider.notifier).update((state) => "Highest");
                        }),
                   const SizedBox(width: 8,),
                    SelectableItem(
                        label: "Lowest",
                        isSelected: sort == "Lowest",
                        onTap: () {
                           ref.read(sortProvider.notifier).update((state) => "Lowest");
                        }),
                           const SizedBox(width: 8,),
                    SelectableItem(
                        label: "Newest", isSelected: sort == "Newest", onTap: () {
                           ref.read(sortProvider.notifier).update((state) => "Newest");
                        }),
                      
                  
                  ],
                  
                ),
                SizedBox(height: 20,),
                  SelectableItem(
                        label: "Oldest", isSelected: sort == "Oldest", onTap: () {
                           ref.read(sortProvider.notifier).update((state) => "Oldest");
                        })    
              ],
            ),
          ),
        );
        },
        
      );
    },
  );
}
