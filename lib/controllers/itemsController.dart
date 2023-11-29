import 'package:auction_app/models/item.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class ItemsController extends GetxController {
  RxList items = [].obs;
  RxBool isLoading = true.obs;
  RxBool isAdding = false.obs;
  Rx<PlatformFile?> pickedFile = Rx<PlatformFile?>(null);

  getItems() => items;
  getIsLoading() => isLoading;
  @override
  void onInit() {
    fetchItems();
    super.onInit();
  }

  void fetchItems() async {
    try {
      isLoading(true);
      var itemsFromServer = await FirebaseFirestore.instance
          .collection('items')
          .get()
          .then((value) =>
              value.docs.map((e) => ItemModel.fromJson(e.data())).toList());
      if (itemsFromServer.isNotEmpty) {
        items.assignAll(itemsFromServer);
      }
    } finally {
      isLoading(false);
    }
  }

  void addItem() async {
    try {
      isAdding(true);
    } finally {
      isAdding(false);
    }
  }

    Future<void> selectFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (result != null) {
      pickedFile.value = result.files.first;
    }
  }

}
