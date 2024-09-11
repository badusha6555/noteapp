import 'package:flutter/material.dart';
import 'package:google_keep/models/data.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<Data>> dataListNotifier = ValueNotifier([]);
Future<void> addData(Data value) async {
  final dataDb = await Hive.openBox<Data>('data_db');
  await dataDb.add(value);
  dataListNotifier.value.add(value);
  dataListNotifier.notifyListeners();
}

Future<void> getData() async {
  final dataDb = await Hive.openBox<Data>('data_db');
  dataListNotifier.value.clear();
  dataListNotifier.value.addAll(dataDb.values);
  dataListNotifier.notifyListeners();
}

Future<void> deleteData(int index) async {
  final dataDb = await Hive.openBox<Data>('data_db');
  await dataDb.deleteAt(index);
  getData();
}

Future<void> editData(index, Data value) async {
  final dataDb = await Hive.openBox<Data>('data_db');
  dataListNotifier.value.clear();
  dataListNotifier.value.addAll(dataDb.values);
  dataListNotifier.notifyListeners();
  dataDb.putAt(index, value);
  getData();
}
