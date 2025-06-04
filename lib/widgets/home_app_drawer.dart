import 'package:flutter/material.dart';
import 'package:movies_app/services/authentication_service.dart';
import 'package:movies_app/services/account_datails_service.dart';
import 'package:movies_app/views/splash_screen.dart';

class HomeAppDrawer extends StatelessWidget {
  const HomeAppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TMDBAuthService authService = TMDBAuthService();
    final String username = AccountDetailsService().getUsername() ?? 'username';
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, // Remove default padding at the top
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(username),
            accountEmail: Text(username),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate or update UI
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to Favorites page
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              // Handle logout
              authService.logout();
              // Go to splash screen and remove all previous routes
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => SplashScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
