
import 'package:auction_app/controllers/itemsController.dart';
import 'package:auction_app/pages/AddItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});
  
    @override
  Widget build(BuildContext context) {
ItemsController itemsController = Get.find();
    return   Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/auction.png" , scale: 2.5,)
                  ],
                ),
              ),
             Row(
      
               children: [
                  const Text("Currently Live Auctions" , style: TextStyle(
                    fontWeight: FontWeight.w500 ,
                    fontSize: 17,
                    color: Colors.black38
                  ),),
                  const Spacer(),
                    IconButton(onPressed: (){
                      Get.to(()=> ItemForm());
                  }, icon: const  Icon(Icons.add , color: Colors.black54,)),
                  IconButton(onPressed: (){
                      itemsController.fetchItems();
                  }, icon: const  Icon(Icons.refresh , color: Colors.black54,))
               ],
             ),  
              Obx(() {
                if(itemsController.isLoading()){
                  return  const CircularProgressIndicator() ;
                }else{
                  return const  Text("Loaded");                }
              })
            ],
          ),
        ),
      ),
    );
  }
}