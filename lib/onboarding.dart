import 'package:flutter/material.dart';
import 'package:flutter_gemini_chat/MyHomePage.dart';

class Onboarding extends StatelessWidget{
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 32),
            Text(
              'Your AI Assistant',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue
              ),
            ),
            
            Text('Use the power of AI to chat with your friends and family', style: TextStyle(color: Colors.black)),
            Image.asset('assets/onboarding.png'),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: (){
                Navigator.pushAndRemoveUntil(
                  context, 
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                  (route) => false 
                  );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                )
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Get Started', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 8),
                  Icon(Icons.arrow_forward, color: Colors.white,)
                ],
              )
            )
          ],
        ),
      )
    );
  }
}