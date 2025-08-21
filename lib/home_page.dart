import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  final List<String> languages = [
    "C",
    "C++",
    "Java",
    "Python",
    "Flutter",
    "JavaScript"
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Select Language"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            if (user != null)
              UserAccountsDrawerHeader(
                accountName: Text("Gourab Mondal"),
                accountEmail: Text(user.email ?? ""),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    "G",
                    style: TextStyle(fontSize: 24, color: Colors.deepPurple),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
              )
            else
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Center(
                  child: Text(
                    "Guest User",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),

            if (user != null) ...[
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                leading: Icon(Icons.admin_panel_settings),
                title: Text("Admin Panel"),
                onTap: () {
                  Navigator.pushNamed(context, '/admin');
                },
              ),
              ListTile(
                leading: Icon(Icons.school),
                title: Text("Mentor Panel"),
                onTap: () {
                  Navigator.pushNamed(context, '/mentor');
                },
              ),
              Divider(),
            ],

            ListTile(
              leading: Icon(Icons.logout),
              title: Text(user != null ? "Logout" : "Back"),
              onTap: () async {
                if (user != null) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/');
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: languages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/practice',
                      arguments: languages[index],
                    );
                  },
                  child: Card(
                    color: Colors.deepPurple[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Center(
                      child: Text(
                        languages[index],
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple[800],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/documents');
              },
              child: Text("View Documents"),
            ),
          ),
        ],
      ),
    );
  }
}
