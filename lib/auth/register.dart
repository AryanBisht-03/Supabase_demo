import 'package:flutter/material.dart';
import 'package:auth_supabase/loadingScreen.dart';
import 'package:auth_supabase/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Register extends StatefulWidget {
  final Function toggleView;

  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String error = '';
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? loadingScreen()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("SignUp in Supa Demo"),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text("Sign In"))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Email"),
                      validator: (val) =>
                          val!.isEmpty ? "Enter an email" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      decoration:
                          textInputDecoration.copyWith(hintText: "Password"),
                      obscureText: true,
                      validator: (val) => val!.length < 6
                          ? "Enter the password 6+ chars long"
                          : null,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await signUpWithEmail(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = "There is some error while registering ";
                            });
                          }
                          else{
                            loading = false;
                            user = result.user;
                            widget.toggleView();
                          }
                        }
                      },
                      color: Colors.brown[800],
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  Future<AuthResponse> signUpWithEmail(email, password) async {
    final AuthResponse res = await supabase.auth
        .signUp(email: email, password: password);
    return res;
  }
}
