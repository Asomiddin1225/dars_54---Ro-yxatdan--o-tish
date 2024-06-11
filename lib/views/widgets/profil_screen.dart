import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _loadProfileData();
  }

  // Future<void> _loadProfileData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     _firstNameController.text = prefs.getString('firstName') ?? '';
  //     _lastNameController.text = prefs.getString('lastName') ?? '';
  //     _phoneNumberController.text = prefs.getString('phoneNumber') ?? '';
  //   });
  // }

  // Future<void> _saveProfileData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('firstName', _firstNameController.text);
  //   await prefs.setString('lastName', _lastNameController.text);
  //   await prefs.setString('phoneNumber', _phoneNumberController.text);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/asom.png'),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                labelText: 'Isim',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                labelText: 'Familiya',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                labelText: 'Telefon raqam',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // _saveProfileData();
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}