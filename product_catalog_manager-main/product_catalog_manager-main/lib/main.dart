import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:product_catalog_manager/core/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'providers/product_provider.dart';
import 'views/home/home_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider creates AND disposes the provider
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        // add more providers here as the app grows
      ],
      child: MaterialApp(
        title: 'Product Catalog',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
