import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/student_model.dart';
import 'package:test_app/services/database_service.dart';
import 'package:test_app/widgets/custom_scaffold.dart';
import 'package:test_app/widgets/custom_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScaffold(
        title: 'Add Profile',
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              CircleAvatar(radius: 68, child: FlutterLogo(size: 68)),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: _nameController,
                hintText: 'Enter your name',
                prefixIcon: Icons.person_2_outlined,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                hintText: 'Enter your age',
                prefixIcon: Icons.numbers_outlined,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: _departmentController,
                hintText: 'Enter your department name',
                prefixIcon: Icons.school_outlined,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  elevation: 10,
                ),
                onPressed: () async {
                  _saveProfile();
                },
                child: Text(
                  'Save profile',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (_nameController.text.isEmpty ||
        _ageController.text.isEmpty ||
        _departmentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields before saving the profile.'),
        ),
      );
    }
    final studentName = _nameController.text.trim();
    final studentAge = int.parse(_ageController.text.trim());
    final studentDepartment = _departmentController.text.trim();
    final studentModel = StudentModel(
      name: studentName,
      age: studentAge,
      department: studentDepartment,
    );
    final int id = await DatabaseService.instance.insertStudentProfile(
      studentModel,
    );
    debugPrint('\n\nCreated Student ID: $id\n\n');

    back();
  }

  void back() {
    if (context.mounted) Navigator.pop(context);
  }
}
