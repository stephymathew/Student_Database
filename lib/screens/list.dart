import 'dart:io';

import 'package:database_flutter/db/functions/db_functions.dart';
import 'package:database_flutter/model/student.dart';
import 'package:database_flutter/screens/datapage.dart';
import 'package:database_flutter/screens/home.dart';
import 'package:database_flutter/screens/profile.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key? key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  
  TextEditingController searchController = TextEditingController();
  String search = '';
@override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Student List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentListNotifier,
              builder: (context, studentList, child) {
                final students = studentList
                    .where((student) =>
                        student.name.toLowerCase().contains(search))
                    .toList();

                return ListView.builder(
                    itemBuilder: (context, index) {
                      final model = students[index];

                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(student: model),
                            ));
                          },
                          title: Text(model.name),
                          subtitle: Text(model.phonenumber),
                          leading: CircleAvatar(
                            backgroundImage: FileImage(File(model.image)),
                          ),
                          trailing: Wrap(children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        DataScreen(model: model),
                                  ));
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  
                                  deleteBox(context,model);

                                 
                                },
                                icon: const Icon(Icons.delete)),
                          ]),
                        ),
                      );
                    },
                    itemCount: students.length);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void deleteBox(BuildContext context,student)async {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text('Delete'),
      content: const Text('Are you sure want to delete'),
      actions: [
        TextButton.icon(onPressed: ()async{
           await delete(model: student);
          Navigator.pop(context);
        }, icon: const Icon(Icons.check), label: const Text('Yes')),
        TextButton.icon(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.close), label: const Text('No')),
      ],
    ),);
  }
}