import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_app/models/student_model.dart';
import 'package:test_app/screens/profile_screen.dart';
import 'package:test_app/screens/view_profile_screen.dart';
import 'package:test_app/services/database_service.dart';
import 'package:test_app/services/shared_prefs_service.dart';
import 'package:test_app/widgets/custom_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<StudentModel> _students = [];
  String? lastViewed;

  @override
  void initState() {
    super.initState();
    _loadStudents();
    _loadLastViewed();
  }

  Future<void> _loadStudents() async {
    _students = await DatabaseService.instance.getAllStudents();
    setState(() {});
  }

  Future<void> _loadLastViewed() async {
    lastViewed = await SharedPrefsService.getLastViewed();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'CampusConnect',
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          elevation: 10,
        ),
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
      child: Column(
        children: [
          if (lastViewed != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Text(
                "Last Viewed: $lastViewed",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                bottom: 80,
                left: 16,
                right: 16,
                top: 20,
              ),
              itemCount: _students.length,
              reverse: true,
              itemBuilder: (context, index) {
                final student = _students[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    leading: CircleAvatar(
                      radius: 40,
                      // backgroundColor: Colors.white,
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
                      onTap: () async {
                        SharedPrefsService.setLastViewed(student.name);
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewProfileScreen(student: student),
                          ),
                        );
                        _loadLastViewed();
                      },
                      child: Icon(
                        Icons.keyboard_arrow_right_outlined,
                        size: 24,
                        // color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
