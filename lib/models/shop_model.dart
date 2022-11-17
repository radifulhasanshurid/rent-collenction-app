class ShopModel {
  int? id;
  String? collectedamount;
  String? collectiondate;
  int? shopid;

  ShopModel({this.id, this.collectedamount, this.collectiondate, this.shopid});

  factory ShopModel.fromMap(Map<dynamic, dynamic> json) {
    return ShopModel(
        id: json['id'],
        collectedamount: json['collectedamount'],
        collectiondate: json['collectiondate'],
        shopid: json['shopid']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'collectedamount': collectedamount,
      'collectiondate': collectiondate,
      'shopid': shopid
    };
  }
}
