// // import 'package:flutter/material.dart';
// // import 'theme_controller.dart';
// // import 'splash_screen.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatefulWidget {
// //   const MyApp({super.key});

// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }

// // class _MyAppState extends State<MyApp> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     // ✅ listen for theme changes
// //     ThemeController.instance.addListener(_onThemeChanged);
// //   }

// //   @override
// //   void dispose() {
// //     ThemeController.instance.removeListener(_onThemeChanged);
// //     super.dispose();
// //   }

// //   void _onThemeChanged() {
// //     setState(() {}); // rebuild MaterialApp when theme changes
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final isDark = ThemeController.instance.isDark;

// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         brightness: Brightness.light,
// //         colorScheme: ColorScheme.fromSeed(
// //           seedColor: Colors.deepPurple,
// //           brightness: Brightness.light,
// //         ),
// //         useMaterial3: true,
// //       ),
// //       darkTheme: ThemeData(
// //         brightness: Brightness.dark,
// //         colorScheme: ColorScheme.fromSeed(
// //           seedColor: Colors.deepPurple,
// //           brightness: Brightness.dark,
// //         ),
// //         useMaterial3: true,
// //       ),
// //       themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
// //       debugShowCheckedModeBanner: false,
// //       home: const SplashScreen(),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'theme_controller.dart';
// import 'splash_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     super.initState();

//     // ✅ listen for theme change
//     ThemeController.instance.addListener(_onThemeChanged);
//   }

//   @override
//   void dispose() {
//     ThemeController.instance.removeListener(_onThemeChanged);
//     super.dispose();
//   }

//   void _onThemeChanged() {
//     setState(() {}); // rebuild app when theme changes
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDark = ThemeController.instance.isDark;

//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         brightness: Brightness.light,
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.deepPurple,
//           brightness: Brightness.light,
//         ),
//         useMaterial3: true,
//       ),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.deepPurple,
//           brightness: Brightness.dark,
//         ),
//         useMaterial3: true,
//       ),
//       themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
//       debugShowCheckedModeBanner: false,
//       home: const SplashScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:theme_proj/data/hive_box.dart';
import 'models/task.dart';
import 'screens/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveBoxes.init();

  // Register adapters
  Hive.registerAdapter(TaskAdapter());

  // Open boxes (synchronously before runApp so UI can use them immediately)
  await Hive.openBox('settings'); // dynamic primitives
  await Hive.openBox<Task>(HiveBoxes.tasks);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomePage(),
    );
  }
}
