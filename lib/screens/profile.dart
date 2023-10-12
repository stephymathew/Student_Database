import 'dart:io';

import 'package:database_flutter/model/student.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Student student;

  ProfileScreen({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: FileImage(File(student.image)),
              radius: 60,
            ),
            const SizedBox(height: 20),
            Text('Name: ${student.name}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Register Number: ${student.register}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Phone Number: +91 ${student.phonenumber}', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
