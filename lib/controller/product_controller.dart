import 'package:get/get.dart';
import 'package:rent_collection_app/models/product.dart';
import 'package:rent_collection_app/repository/product_repo.dart';

class ProductController extends GetxController {
  var allProduct = <Product>[].obs;
  var singleRow = <Product>[].obs;
  ProductRepo productRepo = ProductRepo();

  @override
  void onInit() {
    super.onInit();
    fetchAllProduct();
  }

  fetchAllProduct() async {
    await Future.delayed(Duration(seconds: 1));
    var fetchProduct = await productRepo.getproduct();
    allProduct.value = fetchProduct;
  }

  fetchRow(Product product) async {
    await Future.delayed(Duration(seconds: 1));
    var fetchOneRow = await productRepo.queryRows('id');
    singleRow.value = fetchOneRow.cast<Product>();
  }

  addProduct(Product product) {
    productRepo.add(product);
    fetchAllProduct();
  }

  updateProduct(Product product) {
    productRepo.update(product);
    fetchAllProduct();
  }

  deleteProduct(int id) {
    productRepo.delete(id);
    fetchAllProduct();
  }
}
