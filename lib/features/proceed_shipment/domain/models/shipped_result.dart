class ShippedResult {
  final String id;
  final String shippedItem;

  const ShippedResult({required this.id, required this.shippedItem});

  ShippedResult.fromJson(Map<String, dynamic> json)
      : id = json['Employee_ID'],
        shippedItem = json['Shipped items'];
}
