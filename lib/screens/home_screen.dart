import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/student_model.dart';
import 'package:test_app/screens/profile_screen.dart';
import 'package:test_app/screens/view_profile_screen.dart';
import 'package:test_app/services/database_service.dart';
import 'package:test_app/widgets/custom_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StudentModel> _students = [];
  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    _students = await DatabaseService.instance.getAllStudents();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'CampusConnect',
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
          _loadStudents();
        },
        child: Text(
          'Add a new student profile',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[200],
                child: FlutterLogo(size: 30),
              ),
              title: Text(
                student.name,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                student.department,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewProfileScreen(student: student),
                    ),
                  );
                },
                child: Icon(
                  Icons.keyboard_arrow_right_outlined,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
