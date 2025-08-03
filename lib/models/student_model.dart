class StudentModel {
  final int? id;
  final String name;
  final int age;
  final String department;

  StudentModel({
    this.id,
    required this.name,
    required this.age,
    required this.department,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'age': age,
    'department': department,
  };

  factory StudentModel.fromMap(Map<String, dynamic> map) => StudentModel(
    id: map['id'],
    name: map['name'],
    age: map['age'],
    department: map['department'],
  );
}
