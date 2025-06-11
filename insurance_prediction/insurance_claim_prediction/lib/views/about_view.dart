import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/about_controller.dart';


class AboutPage extends GetView<AboutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Our Team',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo.shade800,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.indigo.shade50, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Meet Our Development Team',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade900),
              ),
              SizedBox(height: 8),
              Text(
                'Creating innovative software solutions',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),
              SizedBox(height: 30),

              // 👇 Loop through team members
              ...controller.teamMembers.map((member) {
                return Column(
                  children: [
                    _buildTeamMemberCard(
                      context,
                      name: member['name']!,
                      imagePath: member['image']!,
                      role: member['role']!,
                      description: member['description']!,
                      github: member['github'],
                      linkedin: member['linkedin'],
                      isLead: member['isLead'] == 'true',
                    ),
                    SizedBox(height: 20),
                  ],
                );
              }).toList(),

              SizedBox(height: 30),
              Text(
                '© 2025 Development Team | All Rights Reserved',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTeamMemberCard(
      BuildContext context, {
        required String name,
        required String imagePath,
        required String role,
        required String description,
        String? github,
        String? linkedin,
        bool isLead = false,
      }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: isLead
                  ? Colors.amber.shade700
                  : Colors.indigo.shade300,
              width: 6,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              if (isLead)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'TEAM LEAD',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade900),
                  ),
                ),
              if (isLead) SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imagePath,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          Icon(Icons.person, size: 80),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo.shade900),
                        ),
                        SizedBox(height: 4),
                        Text(
                          role,
                          style: TextStyle(
                              fontSize: 14, color: Colors.indigo.shade700),
                        ),
                        SizedBox(height: 8),
                        Text(
                          description,
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey.shade700),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            if (github != null)
                              _buildSocialIcon(
                                  icon: Icons.code,
                                  onTap: () => _launchURL(github),
                                  color: Colors.grey.shade800),
                            if (github != null) SizedBox(width: 12),
                            if (linkedin != null)
                              _buildSocialIcon(
                                  icon: Icons.work,
                                  onTap: () => _launchURL(linkedin),
                                  color: Colors.blue.shade800),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Get.snackbar('Error', 'Could not launch $url',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
