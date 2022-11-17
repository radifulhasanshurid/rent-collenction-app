import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rent_collection_app/controller/product_controller.dart';
import 'package:rent_collection_app/models/product.dart';
import 'package:rent_collection_app/views/body_content.dart';
import 'package:rent_collection_app/views/home_page.dart';

class NewInputPage extends StatefulWidget {
  @override
  State<NewInputPage> createState() => _NewInputPageState();
}

class _NewInputPageState extends State<NewInputPage> {
  final productController = Get.put(ProductController());

//TextField Controller
  final shopNameController = TextEditingController();
  final amountController = TextEditingController();
  final collectedAmountController = TextEditingController();
  final dateController = TextEditingController();

  int? productId;
  int? dueResult;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('Input Inmormation'),
      ),
      body: Obx(
        (() => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: shopNameController,
                    decoration: InputDecoration(
                      hintText: 'Shop/Flat Name',
                    ),
                  ),
                  SizedBox(height: 3),
                  TextField(
                    controller: amountController,
                    decoration: InputDecoration(
                      hintText: 'Enter Amount',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 3),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (shopNameController.text != "" &&
                                amountController.text != "") {
                              productController.addProduct(Product(
                                id: null,
                                name: shopNameController.text,
                                price: amountController.text,
                              ));
                              shopNameController.text = "";

                              amountController.text = "";
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => HomePage(),
                            //     ));
                          },
                          child: Text("Add")),
                      SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            if (shopNameController.text != "" &&
                                amountController.text != "") {
                              productController.updateProduct(Product(
                                id: productId,
                                name: shopNameController.text,
                                price: amountController.text,
                              ));
                              shopNameController.text = "";

                              amountController.text = "";
                            }
                          },
                          child: Text("update")),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: productController.allProduct.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            productId = productController.allProduct[index].id!;

                            shopNameController.text =
                                productController.allProduct[index].name!;
                            amountController.text =
                                productController.allProduct[index].price!;

                            // Due Calculation>>

                            // int dokanVhara = int.parse(
                            //     productController.allProduct[index].price!);
                            // int varaDise = int.parse(productController
                            //     .allProduct[index].collectedamount!);
                            // // dueResult = dokanVhara - varaDise;

                            // dueResult = dokanVhara - varaDise;
                            // print(dueResult);
                          },
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(productController.allProduct[index].id
                                      .toString()),
                                  Text(productController
                                      .allProduct[index].name!),
                                  Text(productController
                                      .allProduct[index].price!),
                                  InkWell(
                                    onTap: () {
                                      productController.deleteProduct(
                                          productController
                                              .allProduct[index].id!);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                      size: 16,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            )),
      ),
    ));
  }
}
