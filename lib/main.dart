import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tech_dome_assignment/database/database_helper.dart';
import 'package:tech_dome_assignment/module/splash/splash_screen.dart';
import 'package:tech_dome_assignment/repository/api_repository.dart';

ApiRepository repository = ApiRepository();
DatabaseHelper dbHelper = DatabaseHelper();
BaseOptions options = BaseOptions(
  baseUrl: 'https://api.sampleapis.com',
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  headers: {
    'Accept': 'application/json',
  },
);

Dio dio = Dio(options);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  dio.interceptors.add(PrettyDioLogger());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}


