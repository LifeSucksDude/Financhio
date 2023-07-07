// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:financhio/common/utils/utils.dart';
import 'package:financhio/common/widegets/forAppOverall/clipper.dart';
import 'package:financhio/common/widegets/forAppOverall/customTextFieldApp.dart';
import 'package:financhio/features/authfeatures/controller/authcontroller.dart';
import 'package:financhio/features/forAddingProfile/addAccount.dart';

import '../../../Theme/pallete.dart';

class UpdateAccountPage extends ConsumerStatefulWidget {
  String url;
 route()=> MaterialPageRoute(builder: (context)=> UpdateAccountPage(url: url,));
   UpdateAccountPage({
    required this.url,
  });

  @override
  ConsumerState<UpdateAccountPage> createState() => _UserInformationState();
}

class _UserInformationState extends ConsumerState<UpdateAccountPage> {
  final TextEditingController nameController = TextEditingController();
  File? image;
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }
  void SelectImage()async{
    image= await pickImageFromGallery(context);
    setState(() {
      
    });
  }
  void UpdateUserData()async{
   String name=nameController.text.trim();
   if(name.isNotEmpty){
    ref.read(authControllerProvider).updateInfo(context, name, image);
   }
   else{
    showSnackBar(context: context, content: "Kuch toh change karo sir");
   }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Change Information",),
        centerTitle: true,
        backgroundColor: Pallete.purpleColor,
        foregroundColor: Pallete.whiteColor,

      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(children: [
            ClipPath(
              clipper: MyCustomClipper(),
              child: Container(
                height: 60,
                width: 1000,
                color: Pallete.purpleColor,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Stack(
              children: [
              image==null?CircleAvatar(
                 
                  backgroundImage: NetworkImage(widget.url),
               
                  backgroundColor: Colors.black,
                  radius: 64,
                 
                ):CircleAvatar(
                    backgroundImage: FileImage(image!),
               
                  backgroundColor: Colors.black,
                  radius: 64,
                ),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: () {
                         SelectImage();
                        },
                        icon: const Icon(
                          Icons.add_a_photo_rounded,
                          color: Color.fromRGBO(98, 63, 255, 1),
                          size: 35,
                        )))
              ],
            ),
            SizedBox(
              height: 110,
            ),
            Center(
              child: Container(
                width: 1000,
                child: CustomTextFieldApp(
                  hintText: 'Enter your name',
                  controller: nameController,
                  enabledBorderColor: Color.fromARGB(255, 84, 84, 98),
                  focusedBOrderColor: Color.fromARGB(255, 168, 207, 255),
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            SizedBox(
              height: 110,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Container(
                  height: 70,
                  width: 200,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(40)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16),
                        child: Text("Update Account",
                            style: TextStyle(color: Colors.white)),
                      ),
                      GestureDetector(
                        onTap: () {
                          UpdateUserData();
                       
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(Icons.arrow_forward_ios),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            
          Container(
            height: 200,
                decoration: BoxDecoration(
                  color: Pallete.purpleColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30), topRight: Radius.circular(40)),
                ),
              
            )
          ]),
        ),
      ),
    );
  }
}
