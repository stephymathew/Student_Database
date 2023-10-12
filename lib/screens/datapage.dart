//import 'package:database_flutter/screens/datapage.dart';
import 'dart:io';

import 'package:database_flutter/db/functions/db_functions.dart';
import 'package:database_flutter/model/student.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key,required this.model});

final Student model ;

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final TextEditingController _textController = TextEditingController();

  final TextEditingController _registerController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String image ='';
  @override
  void initState() {
    // TODO: implement initState
    image=widget.model.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _textController.text=widget.model.name;
    _registerController.text=widget.model.register;
    _phoneController.text=widget.model.phonenumber;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               InkWell(onTap: () async{
              final pickedImage=await ImagePicker().pickImage(source: ImageSource.gallery);  
              if(pickedImage != null)
                image = pickedImage.path;
                setState(() {
                  
                });
               },
                 child: CircleAvatar(
                  backgroundImage: FileImage(File(image)),
                  backgroundColor: const Color.fromARGB(255, 17, 14, 14),
                  radius: 60,
                  child: const Icon(Icons.camera),
                             ),
               ),
              const SizedBox(height: 50),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('User name'),
                  SizedBox(height: 50,width: 250,
                    child: TextFormField(
                      controller: _textController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'please enter a user name';
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Register no:'),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: TextFormField(
                      controller: _registerController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding:const  EdgeInsets.symmetric(vertical: 10),
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator:(value) {
                        if(value == null || value.isEmpty){
                          return 'please enter the register  number';
                        }
                        else if(value.length !=5){
                          return'enter a valid register number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const  SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Phone Number:'),
                  SizedBox(
                    width: 250,
                    height: 50,
                    child: TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'please enter a phone number';
                        }
                        else if(value.length !=10){
                          return 'password must be in 10 digits';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                onPressed: ()async {
                if(_formKey.currentState!.validate()) {
                  widget.model.name=_textController.text;
                  widget.model.register=_registerController.text;
                  widget.model.phonenumber=_phoneController.text;
                  widget.model.image=image;
                  await update(model: widget.model);
                  ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content:  Text('updated successfully'),
                        
                        duration: Duration(seconds: 2),
                        ),
                      );
                  Navigator.pop(context);
                  //import 'package:database_flutter/screens/datapage.dart';
                


                }  
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
        ),
);}
}
