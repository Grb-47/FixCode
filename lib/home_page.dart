import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'document_list_page.dart';
import 'language_practice_page.dart';
import 'fixcode_ai_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

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

    // Pages for BottomNavigationBar
    final List<Widget> pages = [
      // Page 0: Home
      SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5), // 🔹 Welcome line উপরে তুলতে হালকা gap

            // Welcome Text
            const Text(
              "  Welcome to Your CODing journey!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.left, // 🔹 true effect
            ),
            const SizedBox(height: 20),

            // Live Courses Section
            const Text(
              "📚 Live Courses",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 190,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCourseCard("Flutter Development", "assets/flutter.png"),
                  _buildCourseCard("Java Programming", "assets/java.png"),
                  _buildCourseCard("Python Complete Course", "assets/python.png"),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Mentors Section
            const Text(
              "👨‍🏫 Our Mentors",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                _buildMentorCard(
                  "Gourab Mondal",
                  "Flutter Mentor",
                  "assets/mentor1.png",
                  "Software Engineer at Google",
                ),
                _buildMentorCard(
                  "Shahreia Alam Ripty",
                  "Java Mentor",
                  "assets/mentor2.png",
                  "Software Engineer at Microsoft",
                ),
                _buildMentorCard(
                  "Marzia Hasan",
                  "Python Mentor",
                  "assets/mentor3.png",
                  "Researcher at MIT",
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Contract Information Section
            const Text(
              "📄 Contract Information",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Contract Name: FixCode Agreement",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Effective Date: 28-Aug-2025",
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      "E-mail: fixcode.nubtk@gmail.com",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Terms: This contract outlines the responsibilities, rules, and obligations of the parties involved in the FixCode platform.",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Page 1: Courses
      Scaffold(
        appBar: AppBar(
          title: const Text("Courses"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple[400],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                _currentIndex = 0; // Back to Home
              });
            },
          ),
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(20),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

      // Page 2: Documents
      DocumentListPage(),

      // Page 3: FixCode AI
      const FixCodeAIPage(),
    ];

    // Only show AppBar + Drawer on Home page
    final bool showHomeUI = _currentIndex == 0;

    return Scaffold(
      appBar: showHomeUI
          ? AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Fix",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              TextSpan(
                text: "Code",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      )
          : null,
      drawer: showHomeUI
          ? Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            if (user != null)
              UserAccountsDrawerHeader(
                accountName: const Text("Gourab Mondal"),
                accountEmail: Text(user.email ?? ""),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    "G",
                    style: TextStyle(
                        fontSize: 24, color: Colors.deepPurple),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.deepPurple,
                ),
              )
            else
              const DrawerHeader(
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
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: const Text("Admin Panel"),
                onTap: () {
                  Navigator.pushNamed(context, '/admin');
                },
              ),
              ListTile(
                leading: const Icon(Icons.school),
                title: const Text("Mentor Panel"),
                onTap: () {
                  Navigator.pushNamed(context, '/mentor');
                },
              ),
              const Divider(),
            ],
            ListTile(
              leading: const Icon(Icons.logout),
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
      )
          : null,
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Courses",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.picture_as_pdf),
            label: "Documents",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy),
            label: "FixCode AI",
          ),
        ],
      ),
    );
  }

  // Helper Widgets
  Widget _buildCourseCard(String title, String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.only(right: 16),
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset(imagePath, fit: BoxFit.contain)),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMentorCard(
      String name, String role, String imagePath, String extraDetail) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imagePath),
              radius: 35,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(role,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.deepPurple)),
                  Text(
                    extraDetail,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
