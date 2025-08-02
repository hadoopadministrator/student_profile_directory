import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/student_model.dart';
import 'package:test_app/widgets/custom_scaffold.dart';

class ViewProfileScreen extends StatefulWidget {
  final StudentModel student;
  const ViewProfileScreen({super.key, required this.student});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScaffold(
        title: 'Student Profile',
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.white,
                    child: FlutterLogo(size: 100),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Name: ${widget.student.name}",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Age: ${widget.student.age}",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Department: ${widget.student.department}",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
