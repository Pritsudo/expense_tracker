import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/TextInputField.dart';

class AddNewCard extends StatelessWidget {
 
  final TextEditingController titleController;
  final TextEditingController priceController;
  const AddNewCard({
    Key? key,
  
    required this.titleController,
    required this.priceController,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
        height: 500,
        child:
        Column(
          children: [
            TextInputField(title: 'Title', titleController: titleController),
            TextInputField(title: 'Price', titleController: priceController,isNumber: true,),

          ],
        )
           
            
            );
  }
}
