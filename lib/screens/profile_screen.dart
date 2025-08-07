import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campus_connect/models/student_model.dart';
import 'package:campus_connect/services/database_service.dart';
import 'package:campus_connect/widgets/custom_scaffold.dart';
import 'package:campus_connect/widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';

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
              Stack(
                children: [
                  CircleAvatar(
                    radius: 90,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : null,
                    child: _imageFile == null
                        ? const FlutterLogo(size: 70)
                        : null,
                  ),

                  Positioned(
                    top: 12,
                    right: 2,
                    child: InkWell(
                      onTap: () {
                        _showDialog();
                      },
                      child: Icon(Icons.edit, size: 40, color: Colors.black),
                    ),
                  ),
                ],
              ),
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
    final profilePath = _imageFile?.path ;
    final studentModel = StudentModel(
      name: studentName,
      age: studentAge,
      department: studentDepartment,
    imagePath: profilePath,
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

  File? _imageFile;
  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          _imageFile = File(pickedImage.path);
        });
      }
    } catch (ex) {
      debugPrint('\n\nException: $ex\n\n');
    }
  }

  void _showDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose Image'),
          actions: [
            TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
          ],
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.camera_alt_rounded, size: 24),
                      SizedBox(width: 10),
                      Text('Camera'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo, size: 24),
                      SizedBox(width: 10),
                      Text('Gallery'),
                    ],
                  ),
                ),
                
                
              ],
            ),
          ),
        );
      },
    );
  }
}
