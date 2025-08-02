import 'package:flutter/material.dart';
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              CustomTextFormField(
                controller: _nameController,
                hintText: 'Enter your name',
                prefixIcon: Icons.person,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: _ageController,
                hintText: 'Enter your age',
                prefixIcon: Icons.person,
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: _departmentController,
                hintText: 'Enter your department name',
                prefixIcon: Icons.person,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Save profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
