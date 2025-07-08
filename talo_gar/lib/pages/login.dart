import 'package:flutter/material.dart';
import 'package:talo_gar/pages/signup.dart'; // Import for navigating to signup page
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication
import 'package:talo_gar/pages/home.dart'; // Import for navigating to home page

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LoginState();
}

class _LoginState extends State<LogIn> {
  // TextEditingControllers for input fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Async function to handle user sign in
  Future<void> _signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Show success message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login successful!')));

      // Navigate to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'An unknown error occurred.';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      } else if (e.code == 'invalid-credential') {
        message = 'Invalid credentials.';
      }
      // Show error message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      // General error handling
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 10, 30, 80), // Darker blue/purple
              Color.fromARGB(255, 24, 90, 232), // Your app's main blue
            ],
          ),
        ),
        child: Stack(
          children: [
            // "Hello Sign in!" text at the top
            Positioned(
              top: 60.0,
              left: 20.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Hello",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign in!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // White login card at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height:
                    MediaQuery.of(context).size.height *
                    0.65, // Adjust height as needed
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gmail Input Field
                      const Text(
                        "Gmail",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(
                            255,
                            50,
                            50,
                            50,
                          ), // Dark grey for label
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                            color: Colors.grey,
                          ),
                          hintText: "example@gmail.com",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 24, 90, 232),
                            ), // App blue for focus
                          ),
                        ),
                        // TODO: Add validation for email input
                      ),
                      const SizedBox(height: 30.0),

                      // Password Input Field
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(
                            255,
                            50,
                            50,
                            50,
                          ), // Dark grey for label
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextField(
                        controller: _passwordController,
                        obscureText: true, // Hide password
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock_outline,
                            color: Colors.grey,
                          ),
                          hintText: "********",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 24, 90, 232),
                            ), // App blue for focus
                          ),
                          // TODO: Add visibility toggle for password
                        ),
                        // TODO: Add validation for password input
                      ),
                      const SizedBox(height: 15.0),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Implement forgot password functionality
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Color.fromARGB(
                                255,
                                24,
                                90,
                                232,
                              ), // App blue for link
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40.0),

                      // Sign In Button
                      Container(
                        width: double.infinity, // Occupy full width
                        height: 55.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(
                                255,
                                125,
                                150,
                                210,
                              ), // Darker red/purple for button
                              Color.fromARGB(
                                255,
                                30,
                                33,
                                192,
                              ), // Lighter red/purple for button
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: _signIn, // Call the _signIn function
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors
                                    .transparent, // Make button background transparent to show gradient
                            shadowColor: Colors.transparent, // Remove shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.zero, // Remove default padding
                          ),
                          child: const Text(
                            "SIGN IN",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50.0),

                      // Don't have account? Sign up
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have account?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to Sign Up page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                color: Color.fromARGB(
                                  255,
                                  24,
                                  90,
                                  232,
                                ), // App blue for link
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
