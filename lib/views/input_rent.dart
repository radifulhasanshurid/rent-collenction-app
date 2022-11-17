import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rent_collection_app/controller/product_controller.dart';
import 'package:rent_collection_app/controller/shop_controller.dart';
import 'package:rent_collection_app/models/product.dart';
import 'package:rent_collection_app/models/shop_model.dart';
import 'package:rent_collection_app/views/rent_installment.dart';

class InputPage extends StatefulWidget {
  final int shopid_input;
  InputPage({required this.shopid_input});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final productController = Get.put(ProductController());
  final shopController = Get.put(ShopDetailController());

//TextField Controller
  final shopNameController = TextEditingController();
  final amountController = TextEditingController();
  final collectedAmountController = TextEditingController();
  final dateController = TextEditingController();

  int? productId;
  int? dueResult;
  int? shopId;
  int? price;

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
                            if (collectedAmountController.text != "" &&
                                dateController.text != "") {
                              shopController.addShopDetails(ShopModel(
                                  id: null,
                                  collectedamount:
                                      collectedAmountController.text,
                                  collectiondate: dateController.text,
                                  shopid: null));
                              collectedAmountController.text = "";
                              dateController.text = "";
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
                                amountController.text != "" &&
                                collectedAmountController.text != "" &&
                                dateController.text != "") {
                              productController.updateProduct(Product(
                                id: productId,
                                name: shopNameController.text,
                                price: amountController.text,
                                // collectedamount:
                                //     collectedAmountController.text,
                                // collectiondate: dateController.text
                              ));
                              shopNameController.text = "";

                              amountController.text = "";
                              collectedAmountController.text = "";
                              dateController.text = "";
                            }
                          },
                          child: Text("update")),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: productController.allProduct.length,
                      itemBuilder: ((context, index) {
                        shopId = productController.allProduct[index].id!;
                        price = int.parse(
                            productController.allProduct[index].price!);
                        print(widget.shopid_input);
                        return InkWell(
                          onTap: () {
                            productId = productController
                                .allProduct[widget.shopid_input].id!;

                            shopNameController.text =
                                productController.allProduct[index].name!;
                            amountController.text =
                                productController.allProduct[index].price!;

                            // collectedAmountController.text = productController
                            //     .allProduct[index].collectedamount!;
                            // dateController.text = productController
                            //     .allProduct[index].collectiondate!;

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
                                  Text(productController
                                      .allProduct[widget.shopid_input].id
                                      .toString()),
                                  Text(productController
                                      .allProduct[widget.shopid_input].name!),
                                  // Text(productController
                                  //     .allProduct[index].price!),
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
                  ),
                  FloatingActionButton.extended(
                      onPressed: () {
                        print(shopId);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => (RentInstallment(
                                shopId: shopId!,
                                price: price!,
                              )),
                            ));
                      },
                      label: Text('Installments'))
                  // Secend List view
                ],
              ),
            )),
      ),
    ));
  }
}
