import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:loc/featuers/auth/presentation/views/login_view.dart';
import 'package:loc/featuers/auth/presentation/views/sginup_view.dart';
import 'package:loc/featuers/book_Hall/presentation/views/book_Loc_view.dart';
import 'package:loc/homePage.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // locale: const Locale('ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: isArabic()? "اماكن":"loc",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
        useMaterial3: true,
      ),
      home: const LoginView(),
      routes: {
        BookLocView.id:(context) => const BookLocView(),
        SignUpView.id:(context) => const SignUpView(),
        LoginView.id:(context) => const LoginView(),
      },
    );
  }
}

bool isArabic(){
  return Intl.getCurrentLocale()== 'ar';
}