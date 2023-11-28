import 'package:auction_app/controllers/authController.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("s"),
            ElevatedButton(onPressed: (){
              AuthController.instance.signOut();
            }, child: Text("logout"))
          ],
        ),
      ),
    );
  }
}