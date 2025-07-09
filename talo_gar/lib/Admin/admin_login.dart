import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // For Firebase Authentication
import 'package:cloud_firestore/cloud_firestore.dart'; // For potential admin role checking
import 'package:talo_gar/Admin/admin_panel.dart'; // Import for navigating to the Admin Panel

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  // TextEditingControllers for input fields
  final TextEditingController _usernameController =
      TextEditingController(); // Changed to username
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose(); // Changed to username
    _passwordController.dispose();
    super.dispose();
  }

  // Async function to handle admin login
  Future<void> _adminLogin() async {
    try {
      final String adminEmail =
          '${_usernameController.text.trim()}@admin.com'; // Construct admin email

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: adminEmail, // Use constructed admin email
            password: _passwordController.text,
          );

      // Check if the authenticated user is an admin by looking up their UID in Firestore
      if (userCredential.user != null) {
        final DocumentSnapshot adminDoc =
            await FirebaseFirestore.instance
                .collection('admins')
                .doc(userCredential.user!.uid)
                .get();

        if (adminDoc.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Admin Login successful!')),
          );
          // Navigate to admin dashboard
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminPanel(),
            ), // Navigate to AdminPanel
          );
        } else {
          await FirebaseAuth.instance.signOut(); // Sign out non-admin users
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Access Denied: Not an administrator.'),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred during login.';
      if (e.code == 'user-not-found') {
        message = 'No user found for that username.'; // Updated message
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      } else if (e.code == 'invalid-email') {
        message = 'The username is not valid.'; // Updated message
      } else if (e.code == 'invalid-credential') {
        message = 'Invalid credentials.';
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // "Admin Login" text at the top
            Positioned(
              top: 60.0,
              left: 20.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Admin",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Login",
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
                      // Username Input Field (formerly Gmail)
                      const Text(
                        "Username", // Changed from Gmail
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
                        controller: _usernameController, // Changed controller
                        keyboardType:
                            TextInputType.text, // Changed keyboard type
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person_outline, // Changed icon to person
                            color: Colors.grey,
                          ),
                          hintText: "admin", // Changed hint text
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 24, 90, 232),
                            ), // App blue for focus
                          ),
                        ),
                        // TODO: Add validation for username input
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

                      // Forgot Password - Keeping as per login page, remove if not needed for admin
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO: Implement forgot password for admin if needed
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

                      // Login Button
                      Container(
                        width: double.infinity,
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
                          onPressed:
                              _adminLogin, // Call the admin login function
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50.0),
                      // Removed "Don't have account? Sign in" section
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
