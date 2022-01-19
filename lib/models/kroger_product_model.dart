class KrogerProductModel {
  final String? name;
  final String? price;
  final String? location;
  final String? qty;
  final String? upc;

  const KrogerProductModel ({
    this.name,
    this.price,
    this.location,
    this.qty,
    this.upc,
  });

  factory KrogerProductModel.fromJson(Map<String, dynamic> json) {
    return KrogerProductModel(
      name: json['name'],
      price: json['price'],
      location: json['location'],
      qty: json['qty'],
      upc: json['upc']
    );
  }
}