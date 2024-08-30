import 'dart:io';

import 'package:finalexam/screen/cart/controller/cart_controller.dart';
import 'package:finalexam/screen/cart/model/cart_model.dart';
import 'package:finalexam/screen/home/controller/home_controller.dart';
import 'package:finalexam/screen/home/model/home_model.dart';
import 'package:finalexam/utils/helper/db_helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  // final CartController Ccontroller=Get.put(CartController());
  final TextEditingController txtProduct = TextEditingController();
  final TextEditingController txtQua = TextEditingController();
  final TextEditingController txtPrice = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         actions: [
           IconButton(onPressed: () {
             Get.toNamed('cart');
           }, icon: Icon(Icons.shopping_cart,color: Colors.white,),)
         ],
        backgroundColor: Colors.black,
        title: Text(
          "Products",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Expanded(
            child: Obx(
          () => ListView.builder(
            itemCount: controller.list.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.primaries[index].shade200,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.list[index].product}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${controller.list[index].qua}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "\$ ${controller.list[index].price}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () async {
                                Get.defaultDialog(
                                  title: "Are you Sure",
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async {
                                        await DBHelper.helper
                                            .delete(controller.list[index].id!);
                                        controller.readData();
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
                                    ),
                                  ],
                                );
                              },
                              icon: Icon(
                                (Icons.delete),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                txtProduct.text =
                                    controller.list[index].product!;
                                txtPrice.text = controller.list[index].price!;
                                txtQua.text = controller.list[index].qua!;
                                Get.defaultDialog(
                                  title: "are you sure",
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: txtProduct,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please Enter product:";
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            label: Text("Product:"),
                                            border: OutlineInputBorder()),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      TextFormField(
                                          controller: txtQua,
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please Enter Quantity:";
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                              label: Text("Quantity:"),
                                              border: OutlineInputBorder())),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      TextFormField(
                                        controller: txtPrice,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please Enter Price:";
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            label: Text("Price:"),
                                            border: OutlineInputBorder()),
                                      ),
                                      const SizedBox(
                                        height: 18,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        String product = txtProduct.text;
                                        String qua = txtQua.text;
                                        String price = txtPrice.text;
                                        dbModel model = dbModel(
                                          id: controller.list[index].id,
                                          product: product,
                                          price: price,
                                          qua: qua,
                                        );
                                        DBHelper.helper.update(model);
                                        controller.readData();
                                        Get.back();
                                        txtPrice.clear();
                                        txtQua.clear();
                                        txtProduct.clear();
                                      },
                                      child: Text("upadate"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text("cancel"),
                                    ),
                                  ],
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () async {
                                dbModel d1=dbModel(
                                  price: controller.list[index].price!,
                                  qua:controller.list[index].qua!,
                                  product: controller.list[index].product!
                                );
                                DBHelper.helper.insertCart(d1);
                                controller.cartRead();
                              },
                              icon: Icon(Icons.favorite_border),
                            ),
                          ],
                        ),
                      ]));
            },
          ),
        ))
      ]),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Get.defaultDialog(
            title: "Add Product",
            content: Form(
              key: key,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: txtProduct,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      label: Text(
                        "Product",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid product name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: txtQua,
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      label: Text(
                        "Quantity",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid quantity";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: txtPrice,
                    autofocus: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      label: Text(
                        "Price",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a valid price";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    final dbModel d1 = dbModel(
                      qua: txtQua.text,
                      product: txtProduct.text,
                      price: txtPrice.text,
                    );
                    DBHelper.helper.insertQuery(d1);
                    controller.readData();
                    txtQua.clear();
                    txtPrice.clear();
                    txtProduct.clear();
                    Get.back();
                  }
                },
                child: Text("Submit"),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel"),
              ),
            ],
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void updateData(dbModel m1) {
    txtProduct.text = m1.product!;
    txtQua.text = m1.qua!;
    txtPrice.text = m1.price!;
    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: const Text("Update Product"),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: key,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: txtProduct,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter product:";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          label: Text("Product:"),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                        controller: txtQua,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Quantity:";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            label: Text("Quantity:"),
                            border: OutlineInputBorder())),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: txtPrice,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Price:";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          label: Text("Price:"), border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Cancel")),
              ElevatedButton(
                child: const Text("Update"),
                onPressed: () async {
                  if (key.currentState!.validate()) {
                    dbModel r1 = dbModel(
                        product: txtProduct.text,
                        qua: txtQua.text,
                        price: txtPrice.text,
                        id: m1.id);
                    DBHelper.helper.update(r1);
                    await controller.readData();
                    Get.back();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
