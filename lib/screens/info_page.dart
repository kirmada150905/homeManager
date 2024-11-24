import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch $url")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About the App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "App Information",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Application built with Flutter for BITS Pilani SUTT App Dev recruitment.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              "Developer",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Developed by: Mohan Krishna",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Text(
              "ID: 2024ADPS0732P",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            const Text(
              "Contact",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Email:", style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () {
                    _launchUrl("mailto:f20240732@pilani.bits-pilani.ac.in");
                  },
                  child: const Text("f20240732@pilani.bits-pilani.ac.in"),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    _launchUrl("https://github.com/kirmada150905");
                  },
                  color: Colors.black,
                  icon: const Icon(SimpleIcons.github),
                  tooltip: "GitHub",
                ),
                IconButton(
                  color: Colors.lightBlue,
                  onPressed: () {
                    _launchUrl(
                        "https://www.linkedin.com/in/mohan-krishna-karthik-549b08323/");
                  },
                  icon: const Icon(SimpleIcons.linkedin),
                  tooltip: "LinkedIn",
                ),
                IconButton(
                  onPressed: () {
                    _launchUrl(
                        "mailto:f20240732@pilani.bits-pilani.ac.in?subject=App%20Query&body=Hello");
                  },
                  icon: const Icon(Icons.mail),
                  color: Colors.orange,
                  tooltip: "Email",
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Spacer(),
            Center(
              child: Text(
                "Version 1.0.0",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
