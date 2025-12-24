import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smartspend/firebase_options.dart';
import 'package:smartspend/route/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SmartSpend());
}

class SmartSpend extends StatelessWidget {
  const SmartSpend({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    home: Scaffold(
      
      body:  // Use the router defined in app_router.dart
          MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    ));
    }}