import 'package:expense_tracker/resource/auth.dart';
import 'package:expense_tracker/widgets/Drawers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../widgets/addNewCard.dart';
import '../widgets/displayed_card.dart';

import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'homepgae';

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  void addCard(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: AddNewCard(
                descriptionController: _descriptionController,
                titlecontroller: _titleController,
                priceController: _priceController),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _titleController.dispose();
  }

  // void filterDate()
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime oneDay = now.subtract(Duration(minutes: 30));
    DateTime week = now.subtract(Duration(minutes: 7));
    DateTime month = now.subtract(Duration(minutes: 50));
    print('App Runned');

    bool isDateFilter = false;
    DateTime selectedDate = now;

    String userId = Provider.of<Authentication>(context).userId;

    List<DocumentSnapshot> documents = [];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => Dialog(
                            child: Container(
                          height: 100,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              InkWell(
                                child: const Text('Show all'),
                                onTap: () {
                                  // selectedDate = oneDay;
                                  setState(() {
                                    isDateFilter = false;
                                  });
                                },
                              ),
                              InkWell(
                                child: const Text('Show Last Month'),
                                onTap: () {
                                  // selectedDate = month;
                                  setState(() {
                                    isDateFilter = true;
                                  });
                                },
                              ),
                              InkWell(
                                child: const Text('Show this week'),
                                onTap: () {
                                  // selectedDate = week;
                                  setState(() {
                                    isDateFilter = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        )));
              },
              icon: Icon(Icons.more_vert))
        ],
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
              // documents = (snapshot.data! as dynamic).docs;

              // documents = documents.where((element) {
              //   var date = element.get('SavedDate');
              //   return month.isBefore(date);
              // }).toList();

              return ListView.builder(
                itemBuilder: (context, index) {
                  return Cards(
                      snap:
                          //  (documents as dynamic).docs[index].data()
                          (snapshot.data as dynamic).docs[index].data());
                },
                itemCount: (snapshot.data as dynamic).docs.length,
                //  (documents as dynamic).docs.length,
              );
            }
          }
          return Column(
            children: [
              ElevatedButton(
                  onPressed: () => addCard(context), child: Text('Add Card'))
            ],
          );
        },
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('Cards')
            // .where('SavedDate', isLessThan: isDateFilter ? selectedDate : null)
            .orderBy('SavedDate', descending: true)
            .
            // ).
            snapshots(),
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
          onPressed: () => addCard(context),
          child: Icon(
            Icons.add_circle_outline,
            size: 30,
          )),
    );
  }
}
