import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // To get current user for potential checks

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(
          255,
          24,
          90,
          232,
        ), // App's primary blue
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100], // Light background for contrast
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('bookings')
                .orderBy('timestamp', descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No bookings found.'));
          }

          // Display bookings as a list of cards
          return ListView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot bookingDoc = snapshot.data!.docs[index];
              Map<String, dynamic> bookingData =
                  bookingDoc.data() as Map<String, dynamic>;

              // Extract data safely
              String service = bookingData['service'] ?? 'N/A Service';
              String userName = bookingData['userName'] ?? 'Unknown User';
              String userEmail = bookingData['userEmail'] ?? 'No Email';
              String bookingTime = bookingData['time'] ?? 'No Time';
              String bookingDate = bookingData['date'] ?? 'No Date';

              // Optional: Format date for display
              // DateTime parsedDate = DateTime.parse(bookingDate); // If date is ISO8601 string
              // String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate); // Requires intl package
              String displayDate =
                  bookingDate.split(
                    'T',
                  )[0]; // Simple split for ISO string if intl not used

              return Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5.0,
                ),
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor
                                .withOpacity(0.2), // Light blue avatar
                            child: Icon(
                              Icons.person,
                              color: Theme.of(context).primaryColor,
                            ), // Person icon
                          ),
                          const SizedBox(width: 15.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                userEmail,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          const Spacer(), // Pushes content to the ends
                          // You could add more icons or status here
                        ],
                      ),
                      const Divider(
                        height: 25.0,
                        thickness: 1.0,
                        color: Colors.grey,
                      ), // Separator
                      Text(
                        'Service: $service',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'Date: $displayDate',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        'Time: $bookingTime',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            // Delete booking from Firestore
                            try {
                              await bookingDoc.reference.delete();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Booking marked as done!'),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Failed to mark as done: ${e.toString()}',
                                  ),
                                ),
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.done_all,
                            color: Colors.white,
                          ), // Done icon
                          label: const Text(
                            "Done",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.green[600], // Green for done action
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
