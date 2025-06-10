import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_foam/my_main_screen/bodypart/abs.dart';
import 'package:login_foam/my_main_screen/bodypart/arm.dart';
import 'package:login_foam/my_main_screen/bodypart/back.dart';
import 'package:login_foam/my_main_screen/bodypart/legs.dart';
import 'package:login_foam/textfeild/login.dart';
import 'bodypart/chest.dart';

class Chosescreen extends StatefulWidget {
  const Chosescreen({super.key});

  @override
  State<Chosescreen> createState() => _ChosescreenState();
}

class _ChosescreenState extends State<Chosescreen> {
  // Track selected body part
  String? selectedPart;

  // List of body parts
  final List<Map<String, dynamic>> bodyParts = [
    {'name': 'Chest', 'icon': Icons.fitness_center},
    {'name': 'Arms', 'icon': Icons.accessibility},
    {'name': 'Back', 'icon': Icons.airline_seat_recline_normal},
    {'name': 'Legs', 'icon': Icons.directions_run},
    {'name': 'Abs', 'icon': Icons.accessibility_new},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Body Part'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('user') // MATCHES your signup collection
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.teal),
                    child: Center(child: CircularProgressIndicator(color: Colors.white)),
                  );
                }

                if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
                  return const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.teal),
                    child: Text(
                      'User Info Not Found',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  );
                }

                final userData = snapshot.data!;
                final name = userData['name'] ?? 'No Name';
                final email = userData['email'] ?? 'No Email';
                final gender = userData['gender'] ?? 'No Gender';

                return DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.teal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(color: Colors.white, fontSize: 22)),
                      Text(email, style: const TextStyle(color: Colors.white70, fontSize: 16)),
                      Text("Gender: $gender", style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.push(context, MaterialPageRoute(builder: (_) => myAppScreen()));
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Choose your focus area:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: bodyParts.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final part = bodyParts[index];
                  final isSelected = selectedPart == part['name'];

                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedPart = part['name'];
                      });

                      // Navigate based on body part
                      if (part['name'] == 'Chest') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ChestScreen()),
                        );
                      }
                      if (part['name'] == 'Back') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => BackScreen()),
                        );
                      }
                      if (part['name'] == 'Legs') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LegsScreen()),
                        );
                      }
                      if (part['name'] == 'Arms') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ArmsScreen()),
                        );
                      }     if (part['name'] == 'Abs') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AbsScreen()),
                        );
                      }
                      // Add similar navigation logic for other parts if needed
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.teal.withOpacity(0.1)
                            : Colors.grey.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.teal : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            part['icon'],
                            color: isSelected ? Colors.teal : Colors.grey[700],
                            size: 28,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            part['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.teal : Colors.black,
                            ),
                          ),
                          const Spacer(),
                          if (isSelected)
                            const Icon(Icons.check_circle, color: Colors.teal),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
