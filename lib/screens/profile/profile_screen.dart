import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  // Start with default/fallback values
  String name = 'User';
  String email = 'user@example.com';
  String avatarUrl = 'https://i.pravatar.cc/300';
  bool isLoading = false; // start false so screen opens immediately

  @override
  void initState() {
    super.initState();
    fetchUserData(); // fetch in background
  }

  Future<void> fetchUserData() async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        setState(() {
          name = doc['name'] ?? name;
          email = doc['email'] ?? email;
          avatarUrl = doc['avatarUrl'] ?? avatarUrl;
        });
      } else {
        // If document does not exist, create default data
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': name,
          'email': FirebaseAuth.instance.currentUser!.email,
          'avatarUrl': avatarUrl,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
      // Keep default values
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    name: name,
                    email: email,
                    avatarUrl: avatarUrl,
                  ),
                ),
              );
              fetchUserData(); // refresh after editing
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(avatarUrl),
            ),
            const SizedBox(height: 16),
            Text(
              name,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              email,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            TextButton.icon(
              onPressed: logout,
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                'Log Out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
