import 'package:care/models/userModel.dart';
import 'package:care/service/authservice.dart';
import 'package:care/service/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const red = const Color.fromARGB(255, 200, 92, 92);

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: red),
        ),
        backgroundColor: (Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 120,
          ),
          Center(
            child: Container(
              height: 473,
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
                    "Sign Up",
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
                    controller: phoneController,
                    style: TextStyle(fontFamily: "Times New Roman", color: red),
                    decoration: InputDecoration(
                      labelText: "Phone",
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
                    padding: EdgeInsets.only(top: 25.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final authService = Authservice();
                        final userService = userServices();

                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty ||
                            phoneController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("All fields are required")),
                          );
                          return;
                        }

                        setState(() => isLoading = true);

                        try {
                          final userCredential = await authService.signUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                          final uid = userCredential.user!.uid;

                          final newUser = appUser(
                            uid: uid,
                            email: emailController.text.trim(),
                            phone: phoneController.text.trim(),
                          );

                          await userService.createUser(newUser);
                          Navigator.of(context).popUntil((route) => route.isFirst);

                          // No navigation — AuthWrapper handles it

                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.message ?? "Signup failed")),
                          );
                        }

                        setState(() => isLoading = false);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                      child: isLoading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: red,
                            ),
                          )
                        : const Text(
                            "Next",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: "Times New Roman",
                              color: red,
                            ),
                          ),
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
