import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rent_collection_app/models/shop_model.dart';
import 'package:rent_collection_app/repository/shop_repo.dart';
import 'package:rent_collection_app/views/rent_installment.dart';

class ShopDetailController extends GetxController {
  int? id;

  ShopDetailController({
    this.id,
  });

  var allShopModel = <ShopModel>[].obs;

  ShopDetailRepo shopDetailRepo = ShopDetailRepo();

  @override
  void onInit() {
    super.onInit();
    fetchAllShopDetails();
  }

  fetchAllShopDetailsById(int shopId) async {
    id = shopId;
    await Future.delayed(Duration(milliseconds: 40));

    var fetchShopDetails = await shopDetailRepo.getshopDetailsById(shopId);
    allShopModel.value = fetchShopDetails;
  }

  fetchAllShopDetails() async {
    await Future.delayed(Duration(seconds: 1));

    var fetchShopDetails = await shopDetailRepo.getshopDetails();
    allShopModel.value = fetchShopDetails;
  }

  addShopDetails(ShopModel shopModel) {
    shopDetailRepo.add(shopModel);
    fetchAllShopDetailsById(id!);
    // fetchAllShopDetails();
  }

  updateShopDetails(ShopModel shopModel) {
    shopDetailRepo.update(shopModel);
    // fetchAllShopDetails();
    fetchAllShopDetailsById(id!);
  }

  deleteShopDetails(int id) {
    shopDetailRepo.delete(id);
    // fetchAllShopDetails();
    fetchAllShopDetailsById(id);
  }
}
