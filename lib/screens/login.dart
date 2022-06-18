import 'package:flutter/material.dart';

import 'package:expense_tracker/resource/utils.dart';
import '../widgets/TextInputField.dart';
import 'HomePage.dart';
import '../resource/auth.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login-screen';

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signUp() async {
    setState(() {
      _isLoading = true;
    });
    String res = await Authentication()
        .SignupUser(_emailController.text, _passwordController.text);
    setState(() {
      _isLoading = false;
    });
    if (res != 'Success') {
      showSnackBar(res, context);
    }
    Navigator.pushReplacementNamed(context,  HomePage.routeName);
  }

  void login() async {
    setState(() {
      _isLoading = true;
    });
    String res = await Authentication()
        .loginUser(_emailController.text, _passwordController.text);
    setState(() {
      _isLoading = false;
    });
    if (res != 'Success') {
      showSnackBar(res, context);
    }
    Navigator.pushReplacementNamed(context, HomePage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                            title: 'Password',
                            titleController: _passwordController),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              login();
                            },
                            child: Text('Submit')),
                        ElevatedButton(
                            onPressed: () {
                              signUp();
                            },
                            child: Text('Submit for signup')),
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
