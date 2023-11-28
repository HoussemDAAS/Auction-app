import 'package:auction_app/models/item.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
class ItemsController extends GetxController{
  RxList items = [].obs  ;
  RxBool isLoading =true.obs ;
  getItems()=>items;
  getIsLoading()=>isLoading ;
  @override
  void onInit() {
   fetchItems();
    super.onInit();
  }

  void fetchItems() async {
    try{
      isLoading(true) ;
      var itemsFromServer = await FirebaseFirestore.instance.collection('items').get().then((value) => 
      value.docs.map((e) => ItemModel.fromJson(e.data())).toList());
      if(itemsFromServer.isNotEmpty){
        items.assignAll(itemsFromServer);
      }
    }finally{
      isLoading(false);
    }
  }
}