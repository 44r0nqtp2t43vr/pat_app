class ShippedResult {
  final String id;
  final String shippedItem;
  final String tipMessage;

  const ShippedResult({required this.id, required this.shippedItem, required this.tipMessage});

  ShippedResult.fromJson(Map<String, dynamic> json, String message)
      : id = json['Employee_ID'],
        shippedItem = json['Shipped items'],
        tipMessage = message;
}
