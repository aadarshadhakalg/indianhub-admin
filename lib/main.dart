import 'package:admin/controller/notification_controller.dart';
import 'package:admin/controller/stat_controller.dart';
import 'package:admin/controller/transaction/transaction_controller.dart';
import 'package:admin/views/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'views/screens/errorscreen.dart';
import 'views/screens/splashscreen.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
//     systemNavigationBarColor: Colors.cyan, // navigation bar color
//     statusBarColor: Colors.cyan,
//     statusBarBrightness: Brightness.light, // status bar color
//     statusBarIconBrightness: Brightness.light, // status bar icons' color
//   ));
//   runApp(
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.light,
//         primarySwatch: Colors.cyan,
//         primaryColor: Colors.cyan,
//         primaryColorBrightness: Brightness.dark,
//         // ignore: deprecated_member_use
//         cursorColor: Colors.cyan,
//         iconTheme: IconThemeData(color: Colors.white),
//         appBarTheme: AppBarTheme(
//           textTheme: TextTheme(
//             headline6: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//       home: AdminApp(),
//     ),
//   );
// }

// class AdminApp extends StatelessWidget {
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       // Initialize FlutterFire:
//       future: _initialization,
//       builder: (context, snapshot) {
//         // If Error initialising firestore, show error screen
//         if (snapshot.hasError) {
//           return ErrorScreen();
//         }

//         // Once Firestore initialized, go to login
//         if (snapshot.connectionState == ConnectionState.done) {
//           return HomeScreen();
//         }

//         // Splash Screen on Initializing Firestore
//         return SplashScreen();
//       },
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put<TransactionController>(TransactionController());
  Get.put<NotificationController>(NotificationController());
  Get.put<StatsController>(StatsController());
  runApp(AdminApp());
}

class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [
        // FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],
      debugShowCheckedModeBanner: false,
      //defaultTransition: Transition.fade,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.cyan,
        primaryColor: Colors.cyan,
        primaryColorBrightness: Brightness.dark,
        // ignore: deprecated_member_use
        cursorColor: Colors.cyan,
        iconTheme: IconThemeData(color: Colors.white),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            headline6: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
