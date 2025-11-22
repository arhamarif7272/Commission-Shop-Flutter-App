import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore

class userinfo extends StatelessWidget {
  const userinfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
          title: const Text("User Management"),
          backgroundColor: Colors.amber
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Fetch all documents from the 'users' collection
        stream: FirebaseFirestore.instance.collection('users').orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          // 1. Handle Errors
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong', style: TextStyle(color: Colors.white)));
          }

          // 2. Handle Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.amber));
          }

          // 3. Handle Empty Data
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 80, color: Colors.white54),
                  SizedBox(height: 10),
                  Text("No users found.", style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            );
          }

          final users = snapshot.data!.docs;

          // 4. Display List of Users
          return ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: users.length,
            itemBuilder: (context, index) {
              var userData = users[index].data() as Map<String, dynamic>;

              String name = userData['name'] ?? 'Unknown';
              String email = userData['email'] ?? 'No Email';
              String role = userData['role'] ?? 'Buyer';

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: _getRoleColor(role),
                    child: Icon(_getRoleIcon(role), color: Colors.white),
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(email, style: TextStyle(color: Colors.grey[700])),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getRoleColor(role).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          role.toUpperCase(),
                          style: TextStyle(
                            color: _getRoleColor(role),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Optional: Add a delete button for admins
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      // Be careful! This permanently deletes the user record from DB
                      FirebaseFirestore.instance.collection('users').doc(users[index].id).delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Helper to get color based on role
  Color _getRoleColor(String role) {
    switch (role) {
      case 'Admin': return Colors.red;
      case 'Seller': return Colors.blue;
      default: return Colors.green; // Buyer
    }
  }

  // Helper to get icon based on role
  IconData _getRoleIcon(String role) {
    switch (role) {
      case 'Admin': return Icons.admin_panel_settings;
      case 'Seller': return Icons.store;
      default: return Icons.shopping_cart;
    }
  }
}