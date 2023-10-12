
import 'dart:io';

import 'package:database_flutter/db/functions/db_functions.dart';
import 'package:database_flutter/model/student.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();

  final TextEditingController _registerController = TextEditingController();

  final TextEditingController _numberController = TextEditingController();
final TextEditingController _markController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  String? _selectedImagePath;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        appBar: AppBar(
          centerTitle: true,
          title: const Text('REGISTRATIONFORM',),
        ), 
      
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _selectedImagePath != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(File(_selectedImagePath!)),
                          radius: 60,
                        )
                      : const CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 17, 14, 14),
                          radius: 60,
                          child: Icon(Icons.camera_alt_outlined),
                        ),
                  ElevatedButton(
                    onPressed: () async {
                      final pickedImage = await _imagePicker.pickImage(
                        source: ImageSource
                            .gallery, // You can change this to ImageSource.camera for taking photos with the camera
                      );
        
                      if (pickedImage != null) {
                        _selectedImagePath = pickedImage.path;
                        setState(() {});
                      }
                    },
                    child: const Text('Select Image'),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      const Text('User name:'),
                      const SizedBox(width: 30),
                      Expanded(
                        child: TextFormField(
                          controller: _textController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(prefix: const SizedBox(width: 10,),
                            contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter a valid user name';
                            } 
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                   const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text('Register no:'),
                      const SizedBox(
                        width: 25,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _registerController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                            fillColor: Colors.grey,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter a valid register number';
                            } else if (value.length != 5) {
                              return 'register number must be in 5 numbers';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Text(' Phone no:'),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _numberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding:const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                            prefix: const Text('+91'),
                            
                            fillColor: Colors.grey,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please enter a phone number';
                            } else if (value.length != 10) {
                              return 'phone number must be 10 digits';
                            }
                            return null;
                          },
                        ),
                        
                        )
                    ]
                      ),
                
                      const SizedBox(height: 10,),
                    
                   Row(
                     children: [
                       TextField(
                         controller: _markController,
                         keyboardType: TextInputType.number,
                         decoration: InputDecoration(
                           contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                           border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                           )
                         ),
                         
                       ),
                     ],
                   ),
                  
                  const SizedBox(height: 100),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() && _selectedImagePath!=null) {
                        Student model = Student(
                          image: _selectedImagePath!,
                            name: _textController.text,
                            register: _registerController.text,
                            phonenumber: _numberController.text, mark: '');
                            
                        await insert(model: model);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content:  Text('Registration successfull'),
                          
                          duration: Duration(seconds: 2),
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Register'),
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


