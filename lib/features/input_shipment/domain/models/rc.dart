class RC {
  final String rcno;
  final String date;
  final String customerName;
  final String productPartNumber;
  final int numberOfProducts;
  int? numberOfShipmentBoxes;
  int? numberOfLastShipmentBoxProducts;

  RC({
    required this.rcno,
    required this.date,
    required this.customerName,
    required this.productPartNumber,
    required this.numberOfProducts,
    this.numberOfShipmentBoxes,
    this.numberOfLastShipmentBoxProducts,
  });
}
