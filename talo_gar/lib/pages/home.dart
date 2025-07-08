import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                      "Mahbub Mahbub",
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
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  fit: FlexFit.tight,
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
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
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
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  fit: FlexFit.tight,
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
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  fit: FlexFit.tight,
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
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  fit: FlexFit.tight,
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
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
