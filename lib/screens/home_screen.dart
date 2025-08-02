import 'package:flutter/material.dart';
import 'package:test_app/screens/profile_screen.dart';
import 'package:test_app/screens/view_profile_screen.dart';
import 'package:test_app/widgets/custom_scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'CampusConnect',
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );
        },
        child: Text('Add a new student profile'),
      ),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.asset(
                'assets/images/airtel.png',
                height: 24,
                width: 24,
                fit: BoxFit.contain,
              ),
              title: Text('name'),
              subtitle: Text('department'),
              trailing: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewProfileScreen(),
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
