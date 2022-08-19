import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  void dispose(){
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
   try{
     await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
     showDialog(context: context, builder: (context){
       return AlertDialog(
         content: Text('Password reset link sent! check your email'),
       );
     });
   } on FirebaseAuthException catch (e){
     print(e);
     showDialog(context: context, builder: (context){
       return AlertDialog(
         content: Text(e.message.toString()),
       );
     });
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text('Enter your E-mail and we will send you a password reset link',textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0
                ),),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      hintText: "Email",
                      border: InputBorder.none
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          MaterialButton(
            child: Text('Reset Password'),
              color: Colors.deepPurple[200],
              onPressed: (){
              passwordReset();
              }
          ),
        ],
      )
    );
  }
}
