import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Authentication
import 'package:talo_gar/pages/login.dart'; // Import for navigating to login page
import 'package:talo_gar/pages/booking.dart';
import 'package:talo_gar/services/shared_pref.dart'; // Import for shared preferences

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _currentUserName = "Guest"; // Default name

  // Async function to handle user sign out
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    // Navigate to login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LogIn()),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? nameFromFirebase =
        user?.displayName; // Get display name from Firebase
    String? nameFromPrefs =
        await SharedpreferenceHelper()
            .getUserName(); // Get name from shared preferences

    setState(() {
      if (nameFromFirebase != null && nameFromFirebase.isNotEmpty) {
        _currentUserName = nameFromFirebase; // Prefer Firebase display name
      } else if (nameFromPrefs != null && nameFromPrefs.isNotEmpty) {
        _currentUserName =
            nameFromPrefs; // Use shared preference name if Firebase display name is null
      } else if (user?.email != null && user!.email!.isNotEmpty) {
        _currentUserName = user.email!; // Fallback to email if no name is set
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 24, 90, 232),
      body: Container(
        margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Text(
                      _currentUserName, // Use the dynamic user name
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 40.0,
                  backgroundImage: AssetImage("images/boy.jpg"),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Divider(color: Colors.white),
            SizedBox(height: 20.0),
            Text(
              "Services",
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to booking page or perform an action
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => Booking(service: "Adult Haircut"),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 128, 217, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/cutting.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Adult Haircut",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to booking page or perform an action
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => Booking(service: "Kids Haircut"),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/kids.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Kids Haircut",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to booking page or perform an action
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Booking(service: "Facials"),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 128, 217, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/facials.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "facials",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to booking page or perform an action
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Booking(service: "Beard Trim"),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/beard.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Beard Trim",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to booking page or perform an action
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Booking(service: "Hairwashing"),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 128, 217, 255),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/hair.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Hairwashing",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  fit: FlexFit.tight,
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to booking page or perform an action
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Booking(service: "Shaving"),
                        ),
                      );
                    },
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "images/shaving.png",
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Shaving",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.0), // Add some space before the button
            ElevatedButton(
              onPressed: _signOut, // Call the sign-out function
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Example button color
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                "Sign Out",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
