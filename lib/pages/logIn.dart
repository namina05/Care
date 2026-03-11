
import 'package:care/service/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' ;
import 'package:care/pages/signUp.dart';


const red = const Color.fromARGB(255, 200, 92, 92);
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              height: 480,
              width: 320,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: const Color.fromARGB(255, 200, 92, 92)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 10,
                    offset: Offset(6, 6),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 60, backgroundImage: AssetImage("assets/c.png")),
                  Text(
                    "Log In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      fontFamily: "Times New Roman",
                      color: red,
                    ),
                  ),
                  TextField(
                    controller: emailController,
                    style: TextStyle(fontFamily: "Times New Roman", color: red),
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        fontFamily: "Times New Roman",
                        color: red,
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: red)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: red)),
                    ),
                  ),
                  TextField(
                    controller: passwordController,
                    style: TextStyle(fontFamily: "Times New Roman", color: red),
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        fontFamily: "Times New Roman",
                        color: red,
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: red)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: red)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final authService = Authservice();
                            try {
                              await authService.logIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context,).showSnackBar(
                                SnackBar(content: Text(e.message ?? "Login failed")),
                              );
                            }
                          },
                          style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.white)),
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: "Times New Roman",
                              color: red,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context,).push(MaterialPageRoute(builder: (context) => Signup()));
                          },
                          child: const Text(
                            "or Sign Up",
                            style: TextStyle(fontSize: 10, color: red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
