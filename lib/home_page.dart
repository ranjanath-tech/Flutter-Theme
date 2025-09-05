import 'package:flutter/material.dart';
import 'theme_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = ThemeController.instance.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text(
                "Menu",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text("About"),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("About clicked")),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile clicked")),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Logout clicked")),
                );
              },
            ),
            ListTile(
              leading: Icon(
                isDark ? Icons.nightlight_round : Icons.wb_sunny,
              ),
              title: Text(isDark ? "Dark Mode" : "Light Mode"),
              onTap: () {
                Navigator.pop(context);
                ThemeController.instance.toggleTheme(); // ✅ toggle global theme
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          "Welcome to Home Pages",
          style: TextStyle(
            fontSize: 20,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
