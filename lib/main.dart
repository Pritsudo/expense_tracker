import 'package:expense_tracker/resource/auth.dart';
import 'package:expense_tracker/screens/login.dart';
import 'package:expense_tracker/widgets/addNewCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './widgets/displayed_card.dart';
import 'package:provider/provider.dart';
import './screens/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(providers: [
        ChangeNotifierProvider<Authentication>(
            create: (BuildContext context) => Authentication(),
            child: MaterialApp(
              title: 'Expenses App',
              theme: ThemeData(
                textTheme: const TextTheme(
                    headline1:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                backgroundColor: Colors.white,
                primarySwatch: Colors.yellow,
                buttonColor: const Color.fromARGB(255, 247, 247, 161),
              ),
              home: StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return HomePage();
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return LoginScreen();
      },
      stream: FirebaseAuth.instance.authStateChanges(),
    ),
              routes: {
                LoginScreen.routeName: (context) => LoginScreen(),
                HomePage.routeName: (context) => HomePage(),
              },
            )
            //   ChangeNotifierProvider.value(value: Authentication(),
            );
    // ]);
  }
}



