import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'routes/router_helper.dart' as router;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales:const  [
      Locale('en','US'),
      Locale('fr','FR'),
    ],
    path: 'assets/translation',
    saveLocale: true,
    fallbackLocale: const Locale('en','US'),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: homeScreen(),
      initialRoute: '/',
      themeMode: ThemeMode.system,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      onGenerateRoute: router.generateRoute,
    );
  }
}
