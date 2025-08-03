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
  String? _lastViewed;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _loadStudents();

    _loadLastViewed();
  }

  Future<void> _loadStudents() async {
    final students = await DatabaseService.instance.getAllStudents();
    _students = students.reversed.toList();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _loadLastViewed() async {
    _lastViewed = await SharedPrefsService.getLastViewed();
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
          _showCircularIndicator();
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
          _loadStudents();
          _pop();
        },
        child: Text(
          'Add a new student profile',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      child: Column(
        children: [
          if (_lastViewed != null && _students.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 20,
                bottom: 30,
              ),
              child: Text(
                "Last Viewed: $_lastViewed",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          Flexible(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: EdgeInsets.only(
                      bottom: 80,
                      left: 16,
                      right: 16,
                      top: 20,
                    ),
                    itemCount: _students.length,
                    reverse: false,
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
                            radius: 34,
                            child: FlutterLogo(size: 34),
                          ),
                          title: Text(
                            student.name,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            student.department,
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                          trailing: GestureDetector(
                            onTap: () async {
                              SharedPrefsService.setLastViewed(
                                studentName: student.name,
                              );
                              _showCircularIndicator();
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ViewProfileScreen(student: student),
                                ),
                              );
                              _loadStudents();
                              _loadLastViewed();
                              _pop();
                            },
                            child: Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: 24,
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

  void _pop() {
    if (context.mounted) Navigator.pop(context);
  }

  void _showCircularIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
  }
}
