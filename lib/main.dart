import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:auth_supabase/auth/sign_inScreen.dart';
import 'package:auth_supabase/auth/register.dart';
import 'package:auth_supabase/homeScreen.dart';
import 'package:auth_supabase/constant.dart';

String email="";
String password="";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://olhjxrxvuxrmedwphgzw.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9saGp4cnh2dXhybWVkd3BoZ3p3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzAxNzA3MTksImV4cCI6MTk4NTc0NjcxOX0.ojggOurdSDkudkTiSJZqAdHte579-mMT6Zg9fOXRuLo",
  );

  runApp(MaterialApp(
    home: Authenticate(),
  ));
}

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  bool homePage = false;

  void toggleView(){
    setState(() {
      showSignIn=!showSignIn;
      if(user!=null)
        homePage = true;
      else
        homePage = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (homePage ? homeScreen(toggleView: toggleView) : (showSignIn? SignIn(toggleView: toggleView) : Register(toggleView: toggleView))),
    );
  }
}




