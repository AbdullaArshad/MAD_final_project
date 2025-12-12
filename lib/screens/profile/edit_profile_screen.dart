import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String avatarUrl;

  const EditProfileScreen({
    super.key,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  String? _avatarUrl;

  final uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _avatarUrl = widget.avatarUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      // Update Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'name': _nameController.text.trim(),
        'avatarUrl': _avatarUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
      Navigator.pop(context); // Go back to ProfileScreen
    }
  }

  void _changeAvatar() {
    final avatarUrls = [
      'https://i.pravatar.cc/300?u=a',
      'https://i.pravatar.cc/300?u=b',
      'https://i.pravatar.cc/300?u=c',
      'https://i.pravatar.cc/300?u=d',
    ];
    setState(() {
      _avatarUrl = avatarUrls[DateTime.now().millisecond % avatarUrls.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text(
              'Save',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _changeAvatar,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(_avatarUrl!),
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
