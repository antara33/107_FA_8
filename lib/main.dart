import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IDCardScreen(),
    );
  }
}



class IDCardScreen extends StatelessWidget {
  const IDCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF274C77),
        centerTitle: true,
        title: const Text(
          "Student ID Card",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: const Center(
        child: FlipIDCard(),
      ),
    );
  }
}



class FlipIDCard extends StatefulWidget {
  const FlipIDCard({super.key});

  @override
  State<FlipIDCard> createState() => _FlipIDCardState();
}

class _FlipIDCardState extends State<FlipIDCard>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isFront = true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
  }

  void flipCard() {
    if (isFront) {
      controller.forward();
    } else {
      controller.reverse();
    }
    isFront = !isFront;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double angle = controller.value * pi;
        return GestureDetector(
          onTap: flipCard, // tap works on both sides
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            child: angle <= pi / 2
                ? const FrontSideCard()
                : Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: const BackSideCard(),
            ),
          ),
        );
      },
    );
  }
}





class FrontSideCard extends StatelessWidget {
  const FrontSideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF274C77),
              Color(0xFF6096BA),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [

              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.network(
                    "https://upload.wikimedia.org/wikipedia/en/6/6e/Leading_University_logo.png",
                    fit: BoxFit.contain,
                    width: 50,
                    height: 50,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.blue,
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.school,
                        color: Colors.blue,
                        size: 30,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "LEADING UNIVERSITY, SYLHET",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.7,
                ),
              ),

              const SizedBox(height: 4),

              const Text(
                "STUDENT IDENTIFICATION CARD",
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),

              const SizedBox(height: 18),

              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 46,
                  backgroundImage: AssetImage("images/profile.png"),
                ),
              ),

              const SizedBox(height: 18),

              buildFrontRow("Name", "Antara Masuma"),
              buildFrontRow("Student ID", "12101107"),
              buildFrontRow("Department", "CSE"),
              buildFrontRow("Program", "BSc in CSE"),
              buildFrontRow("Batch", "62"),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  "Tap to view back side",
                  style: TextStyle(
                    color: Color(0xFF274C77),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class BackSideCard extends StatelessWidget {
  const BackSideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "PERSONAL INFORMATION",
                  style: TextStyle(
                    color: Color(0xFF274C77),
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              buildBackRow(Icons.home, "Address", "Chhatak, Sunamganj, Bangladesh"),
              buildBackRow(Icons.phone, "Telephone", "01717129000"),
              buildBackRow(Icons.smartphone, "Mobile", "+880195340000"),
              buildBackRow(Icons.bloodtype, "Blood Group", "B+"),

              const SizedBox(height: 16),
              const Divider(),

              const Text(
                "TERMS & CONDITIONS",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF274C77),
                ),
              ),

              const SizedBox(height: 6),
              termLine("This card is non-transferable."),
              termLine("Must be shown upon request."),
              termLine("Property of Leading University."),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF274C77).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    "Tap to view front side",
                    style: TextStyle(
                      color: Color(0xFF274C77),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Divider(),

              const Center(
                child: Text(
                  "Valid Until : June 2027",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




Widget buildFrontRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$title:",
          style: const TextStyle(color: Colors.white70),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}


Widget buildBackRow(IconData icon, String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(icon, size: 18, color: Color(0xFF6096BA)),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: "$title: ",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget termLine(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("• "),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
