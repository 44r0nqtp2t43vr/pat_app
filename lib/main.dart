import 'package:flutter/material.dart';
import 'package:pat_app/config/routes/routes.dart';
import 'package:pat_app/config/theme/app_themes.dart';
import 'package:pat_app/injection_container.dart';

void main() async {
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: const [],
    //   child: MaterialApp(
    //     theme: theme(),
    //     debugShowCheckedModeBanner: false,
    //     onGenerateRoute: AppRoutes.onGenerateRoutes,
    //     home: const Scaffold(
    //       body: Center(
    //         child: Text('Hello World!'),
    //       ),
    //     ),
    //   ),
    // );
    return MaterialApp(
      theme: theme(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const Scaffold(),
    );
  }
}
