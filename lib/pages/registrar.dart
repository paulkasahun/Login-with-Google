import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app/services/auth.dart';

import '../components/btn.dart';
import '../components/squaretiel.dart';
import '../components/text_field.dart';

class Register extends StatefulWidget {
  final void Function()? onTap;
  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailController = TextEditingController();

  final paswordController = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

  void disposal() {
    emailController.dispose();
    paswordController.dispose();
    paswordController.dispose();
  }

  signUp() async {
//show loading circle

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

//try creating the user
    try {
      //check passwd confirmation
      if (paswordController.text == confirmpasswordcontroller.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: paswordController.text,
        );
      } else {
        Navigator.pop(context);
        //show error message
        showErrorMessage('password does not match!');
        // Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      //wrong Email
      Navigator.pop(context);
      showErrorMessage(e.code);
    }

    //pop the progress indicator
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                //Logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                //welcome back you have been missied
                Text(
                  "Let's create an account for you!",
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(
                  height: 25,
                ),
                //username textfield
                TextFieldComponent(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                //password textfield
                TextFieldComponent(
                  controller: paswordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFieldComponent(
                  controller: confirmpasswordcontroller,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                //forgot password text

                const SizedBox(
                  height: 30,
                ),
                Button(
                  text: 'Sign Up',
                  onTap: signUp,
                ),
                const SizedBox(
                  height: 30,
                ),

                //continue with apple or google
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[600],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                //logo apple+google
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    SquareTile(
                      onTap: ()=>AuthService().signInWithGoogle(),
                      imagePath: 'asset/images/google.png',
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    SquareTile(
                      onTap: (){},
                      imagePath: 'asset/images/apple.png',
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //not member register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
