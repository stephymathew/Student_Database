class Student {
  int? id;
  String name;
  String register;
  String phonenumber;
  String image;
  String mark;
 

  Student(
      {required this.name,
      required this.register,
      required this.phonenumber,
      required this.image,
      required this.mark,
     
      this.id});

 static Student toStudent(Map<String, Object?> map) {
    Student model = Student(
        name: map['name'] as String,
        register: map['register'] as String,
        phonenumber: map['phone'] as String,
        image: map['image']as String,
        mark: map['mark']as String,
        
        id: map['id'] as int);
    return model;
  }
}
