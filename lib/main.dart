import 'package:flutter/material.dart';

import 'db/functions/db_functions.dart';
import 'screens/list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await createDataBase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'database_flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(225, 30, 23, 61),
      ),
      home: ListScreen(),
    );
  }
}
