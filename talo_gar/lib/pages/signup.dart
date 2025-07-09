import 'package:flutter/material.dart';
import 'package:talo_gar/pages/login.dart'; // Import for navigating back to login
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication
import 'package:talo_gar/pages/home.dart'; // Import for navigating to home page
import 'package:talo_gar/services/shared_pref.dart'; // Import for shared preferences
import 'package:image_picker/image_picker.dart'; // For picking images
import 'dart:io'; // For File class
// Removed: import 'package:firebase_storage/firebase_storage.dart'; // For Firebase Storage

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

  File? _selectedImage; // Variable to store the selected image file

  // Function to pick an image from gallery or camera
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Show option to choose source
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Image Source'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? image = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (image != null) {
                      setState(() {
                        _selectedImage = File(image.path);
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    final XFile? image = await _picker.pickImage(
                      source: ImageSource.camera,
                    );
                    if (image != null) {
                      setState(() {
                        _selectedImage = File(image.path);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Async function to handle user sign up
  Future<void> _signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );

      // Update user display name
      await userCredential.user?.updateDisplayName(_nameController.text.trim());

      // Save user data to shared preferences (without image URL)
      if (userCredential.user != null) {
        await SharedpreferenceHelper().saveUserId(userCredential.user!.uid);
        await SharedpreferenceHelper().saveUserEmail(
          userCredential.user!.email ?? '',
        ); // Use empty string if email is null
        await SharedpreferenceHelper().saveUserName(
          _nameController.text.trim(),
        );
      }

      // Show success message
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration successful!')));

      // Navigate to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'An unknown error occurred.';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
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
                      // Profile Image Selection
                      Center(
                        child: GestureDetector(
                          onTap: _pickImage, // Call the image picker function
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[200],
                            backgroundImage:
                                _selectedImage != null
                                    ? FileImage(_selectedImage!)
                                        as ImageProvider<Object>?
                                    : null, // Display selected image
                            child:
                                _selectedImage == null
                                    ? Icon(
                                      Icons.add_a_photo,
                                      size: 40,
                                      color: Colors.grey[600],
                                    )
                                    : null, // Default icon if no image
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0), // Space after image
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
                          onPressed: _signUp, // Call the _signUp function
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
                      const SizedBox(height: 20.0), // Reduced from 50.0 to 20.0
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
