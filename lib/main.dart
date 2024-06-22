import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:loc/core/notifications/notification_manager/notification_manager_cubit/notification_maneger_cubit.dart';
import 'package:loc/core/utils/constants.dart';
import 'package:loc/core/utils/simple_bloc_observer.dart';
import 'package:loc/featuers/admin/pressntation/view/add_hall_view.dart';
import 'package:loc/featuers/admin/pressntation/view/all_requests_view.dart';
import 'package:loc/featuers/auth/presentation/views/login_view.dart';
import 'package:loc/featuers/auth/presentation/views/password_recovary_view.dart';
import 'package:loc/featuers/admin/pressntation/view/sginup_view.dart';
import 'package:loc/featuers/messages/presentation/views/messages_veiw.dart';
import 'package:loc/featuers/requests/presentatoin/views/requests_view.dart';
import 'package:loc/featuers/settings/presentaiton/manager/local_cubit/local_cubit.dart';
import 'package:loc/featuers/spalsh/presntation/view/splash_view.dart';
import 'package:loc/featuers/home/presentaiton/views/homePage.dart';
import 'featuers/messages/data/models/chat_buble_model.dart';
import 'featuers/messages/data/models/sent_state_enum.dart';
import 'featuers/messages/data/models/times_tamp_adaptor.dart';
import 'featuers/settings/presentaiton/manager/theme_cubit/theme_cubit.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ChatBubleModelAdapter());
  Hive.registerAdapter(TimestampAdapter());
   Hive.registerAdapter(MessageStatusAdapter());
  await Hive.openBox<ChatBubleModel>(kMessagesBox);
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => NotificationManegerCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: locale,
                themeMode: themeMode,
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(
                ).copyWith(
                  scaffoldBackgroundColor: Colors.grey.shade900,
                ),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  S.delegate
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                ],
                home: const SplashView(),
                routes: {
                  SignUpView.id: (context) => const SignUpView(),
                  LoginView.id: (context) => const LoginView(),
                  MyHomePage.id: (context) => const MyHomePage(),
                  PasswordRecoveryVeiw.id: (context) => const PasswordRecoveryVeiw(),
                  AddHallView.id: (context) => const AddHallView(),
                  UserRequests.id: (context) => const UserRequests(),
                  AllRequests.id:(context) => const AllRequests(),
                  MessagesVeiw.id:(context) =>const MessagesVeiw(),
                },
              );
            },
          );
        },
      ),
    );  }
}
