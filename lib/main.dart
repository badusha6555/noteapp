import 'package:flutter/material.dart';
import 'package:google_keep/models/data.dart';
import 'package:google_keep/view/list_data.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(DataAdapter().typeId)) {
    Hive.registerAdapter(DataAdapter());
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Google Keep',
        debugShowCheckedModeBanner: false,
        home: ListData());
  }
}
