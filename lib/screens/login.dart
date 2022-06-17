import 'package:flutter/material.dart';
import '../widgets/TextInputField.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Flexible(
              child: Container(),
              flex: 1,
            ),
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(), 
                  borderRadius: BorderRadius.circular(5)),

              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  TextInputField(
                      title: 'email', titleController: _emailController),
                  TextInputField(
                      title: 'Password', titleController: _passwordController),
                      SizedBox(height: 10,),
                 ElevatedButton(onPressed: (){
                   
                 }, child: Text('Submit'))
                ],
              ),

              
            ),
            Flexible(
              child: Container(),
              flex: 1,
            )
          ],
        )
        // Container(
        //   margin: EdgeInsets.symmetric(horizontal: ),
        // ),
        );
  }
}
