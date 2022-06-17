import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String title;
  final TextEditingController titleController;
  final bool isPass;
  final bool isNumber;

  const TextInputField({Key? key , required this.title, required this.titleController, this.isPass=false, this.isNumber=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
     decoration: InputDecoration(label:Text(title),),
     controller: titleController,
     obscureText: isPass? true:false,
     keyboardType: isNumber?TextInputType.number:null,
    );
  }
}
