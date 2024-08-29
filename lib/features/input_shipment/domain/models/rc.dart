import 'package:equatable/equatable.dart';

class RC extends Equatable {
  final String shippedItem;
  final String customerName;
  final String shipTo;
  final int totalNumberOfShipmentBoxes;

  const RC({
    required this.shippedItem,
    required this.customerName,
    required this.shipTo,
    required this.totalNumberOfShipmentBoxes,
  });

  @override
  List<Object> get props => [shippedItem, customerName, shipTo, totalNumberOfShipmentBoxes];

  RC.fromJson(Map<String, dynamic> json)
      : shippedItem = json['Shipped item'],
        customerName = json['Customer Name'],
        shipTo = json['Ship to'],
        totalNumberOfShipmentBoxes = json['Total Number of Shipment Boxes'];
}
