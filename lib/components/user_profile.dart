import 'package:flutter/material.dart';
import 'package:coffee_shop/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile extends StatelessWidget {
  final AuthService _authService = AuthService();

  UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authService.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            width: 44,
            height: 44,
            child: CircularProgressIndicator(),
          );
        }

        final user = snapshot.data;

        if (user == null) {
          return GestureDetector(
            onTap: () => _authService.signInWithGoogle(),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xff313131),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: () => _showProfileOptions(context, user),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: NetworkImage(user.photoURL ?? ''),
                fit: BoxFit.cover,
                onError: (_, __) => const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showProfileOptions(BuildContext context, User user) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL ?? ''),
              ),
              title: Text(user.displayName ?? 'User'),
              subtitle: Text(user.email ?? ''),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign Out'),
              onTap: () {
                _authService.signOut();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
} 