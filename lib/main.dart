import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loc/core/utils/simple_bloc_observer.dart';
import 'package:loc/featuers/admin/pressntation/view/add_hall_view.dart';
import 'package:loc/featuers/admin/pressntation/view/all_requests_view.dart';
import 'package:loc/featuers/auth/presentation/views/login_view.dart';
import 'package:loc/featuers/auth/presentation/views/password_recovary_view.dart';
import 'package:loc/featuers/admin/pressntation/view/sginup_view.dart';
import 'package:loc/featuers/requests/presentatoin/views/requests_view.dart';
import 'package:loc/featuers/settings/presentaiton/manager/local_cubit/local_cubit.dart';
import 'package:loc/featuers/spalsh/presntation/view/splash_view.dart';
import 'package:loc/featuers/home/presentaiton/views/homePage.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocaleCubit(),
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: locale,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            theme: ThemeData(
              cupertinoOverrideTheme: const CupertinoThemeData(
                textTheme: CupertinoTextThemeData(),
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
              useMaterial3: true,
            ),
            home: const SplashView(),
            routes: {
              SignUpView.id: (context) => const SignUpView(),
              LoginView.id: (context) => const LoginView(),
              MyHomePage.id: (context) => const MyHomePage(),
              PasswordRecoveryVeiw.id: (context) => const PasswordRecoveryVeiw(),
              AddHallView.id: (context) => const AddHallView(),
              UserRequests.id: (context) => const UserRequests(),
              AllRequests.id: (context) => const AllRequests(),
            },
          );
        },
      ),
    );
  }
}
