import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:campus_connect/models/student_model.dart';
import 'package:campus_connect/services/database_service.dart';
import 'package:campus_connect/services/shared_prefs_service.dart';
import 'package:campus_connect/widgets/custom_scaffold.dart';

class ViewProfileScreen extends StatelessWidget {
  final StudentModel student;
  const ViewProfileScreen({super.key, required this.student});

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
                    radius: 68,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage:
                        student.imagePath != null &&
                            student.imagePath!.isNotEmpty
                        ? FileImage(File(student.imagePath!))
                        : null,
                    child:
                        (student.imagePath == null ||
                            student.imagePath!.isEmpty)
                        ? FlutterLogo(size: 68)
                        : null,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Name: ${student.name}",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Age: ${student.age}",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Department: ${student.department}",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 18,
                      ),
                      elevation: 2,
                    ),
                    onPressed: () async {
                      final confirm = await showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Delete Student"),
                          content: const Text(
                            "Are you sure you want to delete this student?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        await DatabaseService().deleteStudentProfile(
                          student.id!,
                        );
                        debugPrint('Deleted student ID: ${student.id!}');
                        final remaining = await DatabaseService()
                            .getAllStudents();
                        if (remaining.isEmpty) {
                          await SharedPrefsService.clearLastViewed();
                        }
                        if (context.mounted) Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Delete profile',
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
        ),
      ),
    );
  }
}
