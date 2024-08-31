import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/helper/db_helper/db_helper.dart';
import '../../home/controller/home_controller.dart';
import '../controller/cart_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.cartRead();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cart",style: TextStyle(color: Colors.black),),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.list1.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Get.defaultDialog(
                      title: "Are you Sure",
                      actions: [
                        ElevatedButton(
                          onPressed: () async {
                            await DBHelper.helper
                                .deleteCart(controller.list1[index].id!);
                            controller.cartRead();
                            Get.back();
                          },
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            "No",
                            style: TextStyle(color: Colors.green),
                          ),
                        )
                      ],
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 120,
                    width: 100,
                    decoration:
                        BoxDecoration(color: Colors.primaries[index].shade300),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.list1[index].product}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20,fontFamily: "f3"),
                        ),
                        Text("\$ ${controller.list1[index].price}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20,fontFamily: "f3")),
                        Text("${controller.list1[index].qua}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20,fontFamily: "f3")),
                      ],
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
