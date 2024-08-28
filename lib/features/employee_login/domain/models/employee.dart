class Employee {
  final String id;
  final String name;

  const Employee({required this.id, required this.name});

  Employee.fromJson(Map<String, dynamic> json)
      : id = json['Employee_ID'],
        name = json['name'];
}
