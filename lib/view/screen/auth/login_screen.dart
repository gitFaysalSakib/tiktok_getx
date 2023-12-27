import 'package:flutter/material.dart';
import 'package:getx_tiktok/view/screen/auth/signup_screen.dart';
import 'package:getx_tiktok/view/widgets/glith.dart';

import '../../../controller/auth_controller.dart';
import '../../widgets/text_input.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlithEffect(child: const Text('TikTok')),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _emailController,
                myIcon: Icons.email,
                myLabelText: "Email",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextInputField(
                controller: _passwordController,
                myIcon: Icons.lock,
                myLabelText: "Password",
                toHide: true,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  AuthController.instance
                      .login(_emailController.text, _passwordController.text);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: Text("Login"))),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => (SignUpScreen())));
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    child: Text("SignUp"))),

                    SizedBox(
              height: 30,
            ),

            // ElevatedButton(
            //     onPressed: () {
            //       Share.share("com.example.getx_tiktok");
            //     },
            //     child: Container(
            //         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            //         child: Text("Share App"))),

                    
          ],
        ),
      ),
    );
  }
}
