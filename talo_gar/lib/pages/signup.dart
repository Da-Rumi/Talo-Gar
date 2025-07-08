import 'package:flutter/material.dart';
import 'package:talo_gar/pages/login.dart'; // Import for navigating back to login

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // TextEditingControllers for input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
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
            // "Create your Account" text at the top
            Positioned(
              top: 60.0,
              left: 20.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Create your",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // White signup card at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height:
                    MediaQuery.of(context).size.height *
                    0.70, // Slightly more height for an extra field
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
                  ).copyWith(bottom: 20.0), // Added bottom padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name Input Field
                      const Text(
                        "Name",
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
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Colors.grey,
                          ),
                          hintText: "Your Name",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 24, 90, 232),
                            ), // App blue for focus
                          ),
                        ),
                        // TODO: Add validation for name input
                      ),
                      const SizedBox(height: 30.0),

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

                      // Forgot Password (Optional for Sign Up, but keeping structure)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Implement forgot password functionality or remove if not needed for sign up
                          },
                          child: const Text(
                            "Forgot Password?", // Could be removed for sign up, or changed to a different relevant link
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

                      // Sign Up Button
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
                              ), // Light blue for button
                              Color.fromARGB(
                                255,
                                30,
                                33,
                                192,
                              ), // Darker blue for button
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Implement Firebase Sign Up logic here
                            // Use _nameController.text, _emailController.text, and _passwordController.text
                            print("Name: ${_nameController.text}");
                            print("Email: ${_emailController.text}");
                            print("Password: ${_passwordController.text}");
                          },
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
                            "SIGN UP",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50.0),

                      // Already have an account? Sign in
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16.0,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate back to Login page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LogIn(),
                                ),
                              );
                            },
                            child: const Text(
                              "Sign in",
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
