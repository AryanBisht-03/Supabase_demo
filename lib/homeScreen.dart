import 'package:auth_supabase/loadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:auth_supabase/constant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
class homeScreen extends StatefulWidget {

  final Function toggleView;
  homeScreen({required this.toggleView});

  @override
  State<homeScreen> createState() => _homePageState();
}

class _homePageState extends State<homeScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? loadingScreen() : Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Supa Demo"),
    ),
    body: Container(
    padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
    child: Column(
    children: [
      SizedBox(height: 20.0,),
      RaisedButton(
        onPressed: () async {
          setState(() {
            loading = true;
          });
          await signOut();
          user = null;
          setState(() {
            loading = false;
          });
          widget.toggleView();
        },
        child: Text(
          "Log out",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ])));
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }
}
