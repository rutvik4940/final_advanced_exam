import 'package:finalexam/screen/home/model/db_model.dart';
import 'package:finalexam/utils/helper/db_helper/db_helper.dart';
import 'package:finalexam/utils/helper/fb_helper/fb_helper.dart';
import 'package:get/get.dart';

import '../../cart/model/cart_model.dart';

class HomeController extends GetxController {
  RxString? path;
  RxString? addImage;
  RxString? editimage = "".obs;
  RxList<dbModel>list = <dbModel>[].obs;
  RxList<cartModel>list1 = <cartModel>[].obs;

  void edit(String i) {
    editimage = i.obs;
  }

  void editI(String p1) {
    addImage = p1.obs;
  }

  void addPath(String p1) {
    path = p1.obs;
  }

  // Future<void> readData() async {
  //   List<dbModel>?l1 = await DBHelper.helper.read();
  //   if (l1 != null) {
  //     list.value = l1;
  //   }
  // }
  //
  Future<void> cartRead() async {
    List<cartModel>? c1 = await DBHelper.helper.readCart();
    if (c1 != null) {
      list1.value = c1;
    }
  }
Future<void> readData()
async {
  List<dbModel>d1=await FBHelper.helper.read();
  list.value=d1;
 }

}
