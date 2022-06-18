import 'package:expense_tracker/resource/utils.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/TextInputField.dart';
import 'package:provider/provider.dart';
import '../resource/auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class AddNewCard extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController priceController;
  const AddNewCard({
    Key? key,
    required this.titleController,
    required this.priceController,
  }) : super(key: key);

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  bool _isLoading = false;
  String responce = '';

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<Authentication>(context).userId;

    void saveCards(String title, String price) async {
      String cardId = Uuid().v1();
      setState(() {
        _isLoading = true;
      });
      try {
        if (title.isNotEmpty || price.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('Cards')
              .doc(cardId)
              .set({
            'cardId': cardId,
            'title': title,
            'price': price,
          });

          responce = 'Uploaded Successfully';

          widget.titleController.text = '';
          widget.priceController.text = '';
        } else {
          responce = 'Please fill both field';
        }
      } catch (err) {
        responce = err.toString();
      }

      setState(() {
        _isLoading = false;
      });
    }

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 500,
            child: Column(
              children: [
                TextInputField(
                    title: 'Title', titleController: widget.titleController),
                TextInputField(
                  title: 'Price',
                  titleController: widget.priceController,
                  isNumber: true,
                ),
                ElevatedButton(
                    onPressed: () => saveCards(widget.titleController.text,
                        widget.priceController.text),
                    child: Text('Save'))
              ],
            ));
  }
}
