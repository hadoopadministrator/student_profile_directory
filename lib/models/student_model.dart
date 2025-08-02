class StudentModel {
  final int? id;
  final String? name;
  final int? age;
  final String? department;

  StudentModel({this.id, this.name, this.age, this.department});
  //  For SQLite
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'age': age,
    'department': department,
  };

  //  For SQLite
  factory StudentModel.fromMap(Map<String, dynamic> map) => StudentModel(
    id: map['id'],
    name: map['name'],
    age: map['age'],
    department: map['department'],
  );
}
