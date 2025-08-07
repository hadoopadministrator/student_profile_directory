class StudentModel {
  final int? id;
  final String name;
  final int age;
  final String department;
  final String? imagePath;

  StudentModel({
    this.id,
    required this.name,
    required this.age,
    required this.department,
    this.imagePath
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'age': age,
    'department': department,
    'imagePath':imagePath,
  };

  factory StudentModel.fromMap(Map<String, dynamic> map) => StudentModel(
    id: map['id'],
    name: map['name'],
    age: map['age'],
    department: map['department'],
    imagePath: map['imagePath'],
  );
}
