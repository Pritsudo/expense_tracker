import 'package:expense_tracker/resource/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/addNewCard.dart';
import '../widgets/displayed_card.dart';

import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'homepgae';
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
                titleController: _titleController,
                priceController: _priceController),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<Authentication>(context).userId;
    String title;
    double price;

    return Scaffold(
        appBar: AppBar(
          title: const Text('See Expenses'),
          centerTitle: true,
        ),
        body: StreamBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
             
                return 
                // SafeArea(
                  // child:
                   ListView.builder(
                    itemBuilder: (context, index) { 
                      return Cards(
                    snap:(snapshot.data as dynamic).docs[index].data());
                    },
                    itemCount: (snapshot.data! as dynamic).docs.length,
                  );
                // );
              }
            }
              return Column(
                children: [
                  ElevatedButton(
                      onPressed: () => addCard(context),
                      child: Text('Add Card'))
                ],
              );
          },
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(userId).collection('Cards')
              .snapshots(),
        )
        //  SafeArea(

        // child: ListView.builder(
        //   itemBuilder: (context, index) => Cards(price: price, title: title),
        //   itemCount: 3,
        // ),
        // // ),
        // // floatingActionButton: FloatingActionButton(
        // //   onPressed: () {
        // //     addCard(context);
        // //   },
        // //   child: Icon(
        // //     Icons.add_circle,
        // //     size: 52,
        // //   ),
        // )
        );
  }
}
