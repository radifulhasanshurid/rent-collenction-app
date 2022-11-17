import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rent_collection_app/controller/product_controller.dart';
import 'package:rent_collection_app/views/loading_page.dart';
import 'package:rent_collection_app/views/rent_installment.dart';

import '../controller/shop_controller.dart';
import 'new_input.dart';

class body_content extends StatefulWidget {
  @override
  State<body_content> createState() => _body_contentState();
}

class _body_contentState extends State<body_content> {
  bool isLoading = false;
  //controller
  final productController = Get.put(ProductController());
  final shopload = Get.put(ShopDetailController());

  var shopController;

//To pass id
  int? productID;
  int? shopPrice;

  @override
  Widget build(BuildContext context) => isLoading
      ? LoadingPage()
      : Scaffold(
          body: Obx((() => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: productController.allProduct.length,
                        itemBuilder: (context, index) {
                          // productID = index;

                          return Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text('Name'),
                                      SizedBox(height: 5),
                                      InkWell(
                                        onTap: () async {
                                          productID = productController
                                              .allProduct[index].id!;
                                          shopPrice = int.parse(
                                              productController
                                                  .allProduct[index].price!);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RentInstallment(
                                                        shopId: productID!,
                                                        price: shopPrice!,
                                                      )));

                                          // Loading Page set change
                                          setState(() => isLoading = true);
                                          await Future.delayed(
                                              Duration(seconds: 2));
                                          setState(() => isLoading = false);
                                        },
                                        child: Text(
                                          productController
                                              .allProduct[index].name!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text('Collection'),
                                      SizedBox(height: 2),
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.add)),
                                      Text('Due'),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text('Amount'),
                                    SizedBox(height: 5),
                                    Text('hlo'),
                                    SizedBox(height: 5),
                                    Text('1000/- 16/12/2022'),
                                    SizedBox(height: 5),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.balance,
                                          size: 15,
                                        )),
                                    SizedBox(height: 5),
                                    Text('1000/-'),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    FloatingActionButton.extended(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewInputPage(),
                              ));
                        },
                        label: Text('ADD / Update'))
                  ],
                ),
              ))));
}
