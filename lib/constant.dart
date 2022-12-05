import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.brown,width: 2)
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey,width: 2)
  )
);

late User? user = null;
