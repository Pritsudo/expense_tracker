import 'package:expense_tracker/screens/login.dart';
import 'package:expense_tracker/widgets/addNewCard.dart';
import 'package:flutter/material.dart';
import './widgets/displayed_card.dart';
import './widgets/TextInputField.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        primarySwatch: Colors.yellow,
        buttonColor: const Color.fromARGB(255, 247, 247, 161),
      ),
      home: LoginScreen(),
    );
  }
}

class HomePage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  HomePage({Key? key}) : super(key: key);

  void addCard(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: AddNewCard(
                title: 'dddddddd', titleController: _titleController,priceController: _priceController),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String title = 'Candy';
    double price = 52.0;

    return Scaffold(
        appBar: AppBar(
          title: const Text('See Expenses'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView.builder(
            itemBuilder: (context, index) => Cards(price: price, title: title),
            itemCount: 3,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addCard(context);
          },
          child: Icon(
            Icons.add_circle,
            size: 52,
          ),
        ));
  }
}
