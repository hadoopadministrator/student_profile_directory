import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final String? title;
  // final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const CustomScaffold({
    super.key,
    required this.child,
    this.title,
    // required this.automaticallyImplyLeading,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        actions: actions,
        backgroundColor: Colors.white,
        // automaticallyImplyLeading: automaticallyImplyLeading,
        elevation: 0.2,
        title: Text(
          title ?? '',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SafeArea(child: child),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
