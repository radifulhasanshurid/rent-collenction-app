import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rent_collection_app/controller/product_controller.dart';
import 'package:rent_collection_app/controller/shop_controller.dart';

import 'package:rent_collection_app/models/shop_model.dart';

import 'home_page.dart';

class RentInstallment extends StatefulWidget {
  final int shopId;
  final int price;

  RentInstallment({required this.shopId, required this.price});

  @override
  State<RentInstallment> createState() => _RentInstallmentState();
}

class _RentInstallmentState extends State<RentInstallment> {
  final productController = Get.put(ProductController());

  bool isLoading = false;
  var shopController;
  int? rentId;
  int totalRent = 0;
  int? due;

//TextField Controller

  final collectedAmountController = TextEditingController();
  final dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    shopController = Get.put(ShopDetailController(
      id: widget.shopId,
    ));
    shopController.fetchAllShopDetailsById(widget.shopId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('Rent Inmormation'),
        leading: IconButton(
          icon: Icon(Icons.backspace),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          },
        ),
      ),
      body: Obx(
        (() => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(height: 3),
                  TextField(
                    controller: collectedAmountController,
                    decoration: InputDecoration(
                      hintText: 'Collected Amount',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 3),

                  TextFormField(
                    controller: dateController,
                    keyboardType: TextInputType.none,
                    decoration: InputDecoration(
                      hintText: 'Collention Date ',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Date can not be empty';
                      }
                      return null;
                    },
                    onTap: () => pickDateOfCollection(context),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (collectedAmountController.text != "" &&
                                dateController.text != "") {
                              shopController.addShopDetails(ShopModel(
                                  id: null,
                                  collectedamount:
                                      collectedAmountController.text,
                                  collectiondate: dateController.text,
                                  shopid: widget.shopId));
                              collectedAmountController.text = "";
                              dateController.text = "";
                            }
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => HomePage(),
                            //     ));
                            // setState(() {
                            //   RentInstallment(shopId: widget.shopId);
                            // });
                          },
                          child: Text("Add")),
                      SizedBox(width: 10),
                      ElevatedButton(
                          onPressed: () {
                            if (collectedAmountController.text != "" &&
                                dateController.text != "") {
                              shopController.updateShopDetails(ShopModel(
                                  id: rentId,
                                  collectedamount:
                                      collectedAmountController.text,
                                  collectiondate: dateController.text,
                                  shopid: widget.shopId));

                              collectedAmountController.text = "";
                              dateController.text = "";
                            }
                          },
                          child: Text("update")),
                    ],
                  ),

                  // Titles of Contents
                  Card(
                      child: Container(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Collections',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 50),
                            Text(
                              'Date',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),

// Second ListView Model
// RefreshIndicator(child: child, onRefresh: onRefresh)
                  Expanded(
                    child: ListView.builder(
                      itemCount: shopController.allShopModel.length,
                      itemBuilder: ((context, index1) {
                        // print(shopController.allShopModel[index1].shopid
                        //     .toString());
                        print(widget.price);
                        if (shopController.allShopModel[0].shopid! ==
                            widget.shopId) {
                          totalRent = totalRent +
                              int.parse(shopController
                                  .allShopModel[index1].collectedamount!
                                  .toString());
                          print(totalRent);
                          due = widget.price - totalRent;
                        }

                        return InkWell(
                          onTap: () {
                            rentId = shopController.allShopModel[index1].id!;
                            collectedAmountController.text = shopController
                                .allShopModel[index1].collectedamount!;
                            dateController.text = shopController
                                .allShopModel[index1].collectiondate!;

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => ShopDetailController(),
                            //     ));
                          },
                          child: Card(
                            child: Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        shopController.allShopModel[index1]
                                            .collectedamount!,
                                      ),
                                      SizedBox(width: 10),
                                      Text(shopController.allShopModel[index1]
                                          .collectiondate!),

                                      // SizedBox(width: 10),
                                      // Text(shopController
                                      //     .allShopModel[index1].shopid
                                      //     .toString()),
                                      InkWell(
                                        onTap: () {
                                          shopController.deleteShopDetails(
                                              shopController
                                                  .allShopModel[index1].id!);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RentInstallment(
                                                  shopId: widget.shopId,
                                                  price: widget.price,
                                                ),
                                              ));
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  // FloatingActionButton.extended(
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => HomePage(),
                  //         ));
                  //   },
                  //   label: Text(totalRent.toString()),
                  // )
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Total : ${totalRent.toString()}',
                        style: TextStyle(
                            backgroundColor: Colors.black,
                            color: Colors.white,
                            fontSize: 30),
                      ),
                      Text('due : ${due}',
                          style: TextStyle(
                              backgroundColor: Colors.black,
                              color: Colors.white,
                              fontSize: 30))
                    ],
                  )
                ],
              ),
            )),
      ),
    ));
  }

  Future<void> pickDateOfCollection(BuildContext context) async {
    DateTime date = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) {
          return Theme(
            data: ThemeData().copyWith(
              colorScheme: const ColorScheme.light(
                  primary: Colors.pink,
                  onPrimary: Colors.white,
                  onSurface: Colors.black),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? const Text(''),
          );
        });

    if (newDate == null) {
      return;
    }
    setState(() {
      dateController.text = DateFormat('yyyy-MM-dd ').format(newDate);
    });
  }
}
