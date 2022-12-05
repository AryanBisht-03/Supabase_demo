
import 'package:flutter/material.dart';
import 'package:auth_supabase/loadingScreen.dart';
import 'package:auth_supabase/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


final supabaseSignIn = Supabase.instance.client;
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  String error = '';
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email="",password="";

  @override
  Widget build(BuildContext context) {
    return loading ? loadingScreen() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Supa Demo"),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toggleView();
          },
              icon: Icon(Icons.person),
              label: Text("SignUp"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Email"),
                validator: (val) => val!.isEmpty ? "Enter an email" : null,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: "Password"),
                validator: (val) => val!.length < 6 ? "Enter the password 6+ chars long" : null,
                onChanged: (val){
                  setState(() => password = val);
                },
                obscureText: true,
              ),
              SizedBox(height: 20.0,),
              RaisedButton(onPressed: () async {
                if(_formKey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  dynamic result =
                  await signInWithEmail(email, password);
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
                child: Text("Sign In",
                style: TextStyle(
                  color: Colors.white,
                  ),
                ),
              ),
              Text(error,
              style: TextStyle(
                color: Colors.red[800]
              ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<AuthResponse?> signInWithEmail(email, password) async {
    try {
      final AuthResponse res = await supabaseSignIn.auth
          .signInWithPassword(email: email, password: password);
      return res;
    }
    catch(error){
      print(error);
      return null;
    }

  }
}
