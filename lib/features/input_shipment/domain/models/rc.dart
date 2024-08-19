class RC {
  final String rcno;
  final String date;
  final String customerName;
  final String productPartNumber;
  final int numberOfProducts;
  final int? numberOfShipmentBoxes;
  final int? numberOfLastShipmentBoxProducts;

  const RC({
    required this.rcno,
    required this.date,
    required this.customerName,
    required this.productPartNumber,
    required this.numberOfProducts,
    this.numberOfShipmentBoxes,
    this.numberOfLastShipmentBoxProducts,
  });
}
