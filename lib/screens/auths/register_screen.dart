import 'dart:convert';

import 'package:csr/services/auths.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();

  final _textEditingControllerFirstName = TextEditingController();
  final _textEditingControllerLastName = TextEditingController();
  final _textEditingControllerPhoneNumber = TextEditingController();
  final _textEditingControllerEmail = TextEditingController();
  final _textEditingControllerPassword = TextEditingController();
  final _lastNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confPasswordFocusNode = FocusNode();
  var _isLoading = false;

  void _registerUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    final apiResponse = await Provider.of<Auth>(context, listen: false)
        .register(
            _textEditingControllerFirstName.text,
            _textEditingControllerLastName.text,
            _textEditingControllerEmail.text,
            _textEditingControllerPhoneNumber.text,
            _textEditingControllerPassword.text);
    setState(() {
      _isLoading = false;
    });
    if (apiResponse.error == null) {
      _redirectToLogin();
      //_redirectToHome(apiResponse.data as User);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Account created successfully. You can now able to login..'),
        duration: Duration(seconds: 10),
      ));
    } else {
      final responseError = jsonDecode(apiResponse.error as String);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            responseError['phone_number'] == null
                ? Container()
                : Text(responseError['phone_number'].toString()),
            responseError['email'] == null
                ? Container()
                : Text(responseError['email'].toString()),
            responseError['password'] == null
                ? Container()
                : Text(responseError['password'].toString()),
          ],
        ),
      ));
    }
  }

  void _redirectToLogin() {
     Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: const Text('Create Account+'),
        ),
        body: Card(
          margin: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: _textEditingControllerFirstName,
                      decoration: const InputDecoration(
                        labelText: "First name",
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'First name is required.' : null,
                      onFieldSubmitted: (value) {
                        if (value.isEmpty) {
                          return;
                        }
                        FocusScope.of(context).requestFocus(_lastNameFocusNode);
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _textEditingControllerLastName,
                      decoration: const InputDecoration(
                        labelText: "Last name",
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Last name is required.' : null,
                      focusNode: _lastNameFocusNode,
                      onFieldSubmitted: (value) {
                        if (value.isEmpty) {
                          return;
                        }
                        FocusScope.of(context).requestFocus(_emailFocusNode);
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _textEditingControllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email Address",
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Email is required.' : null,
                      focusNode: _emailFocusNode,
                      onFieldSubmitted: (value) {
                        if (value.isEmpty) {
                          return;
                        }
                        FocusScope.of(context)
                            .requestFocus(_phoneNumberFocusNode);
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _textEditingControllerPhoneNumber,
                      decoration: const InputDecoration(
                        labelText: "Phone number",
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Phone number is required.' : null,
                      focusNode: _phoneNumberFocusNode,
                      onFieldSubmitted: (value) {
                        if (value.isEmpty) {
                          return;
                        }
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: _textEditingControllerPassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                      validator: (val) =>
                          val!.isEmpty ? 'Password is required.' : null,
                      focusNode: _passwordFocusNode,
                      onFieldSubmitted: (value) {
                        if (value.isEmpty) {
                          return;
                        }
                        FocusScope.of(context)
                            .requestFocus(_confPasswordFocusNode);
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Confirm Password",
                      ),
                      validator: (val) =>
                          val != _textEditingControllerPassword.text
                              ? 'Please match password.'
                              : null,
                      focusNode: _confPasswordFocusNode,
                      onFieldSubmitted: (_)=>_registerUser(),
                    ),
                    const SizedBox(height: 5),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue),
                                onPressed: _registerUser,
                                child: const Text('Create Account')),
                          ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () => _openLoginPage(context),
                      child: const Center(
                          child: Text('Already have account? Login')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openLoginPage(BuildContext context) {
     Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}
