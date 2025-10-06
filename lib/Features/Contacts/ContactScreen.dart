import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Contactscreen extends StatelessWidget {
  const Contactscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add your action here
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Contact Screen'),
      ),
    );
  }
}
