import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String title;
  final double price;
  const Cards({Key? key, required this.price, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        elevation: 2,color:Color.fromARGB(255, 173, 173, 145),
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: ListTile(
            title: Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          subtitle: Text('THis is subtitle dsiudisd'),
          trailing: Text(
            '\₹ ${price.toString()}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
