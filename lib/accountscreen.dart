import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmoney/models/buttonStyle.dart';
import 'package:ezmoney/profilepic.dart';
import 'package:ezmoney/startpage.dart';
import '/profileedit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'authenticator.dart';
import 'models/appstyle.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Widget accountProfile(User? user) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('User')
          .doc(user?.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show a loading indicator while data is being fetched.
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Text(
              "User not found"); // Handle the case where the user document does not exist.
        }
        var userData = snapshot.data!.data() as Map<String, dynamic>;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: ListView(
            // ...
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      if (userData['Image'] != null &&
                          userData['Image'].isNotEmpty)
                        CircleAvatar(
                          backgroundImage: NetworkImage(userData['Image']),
                          radius: 40,
                        )
                      else
                        const Icon(
                          Icons.account_circle_outlined,
                          size: 85,
                          color: Color.fromRGBO(250, 250, 250, 1),
                        ),
                      Positioned(
                        bottom: -3,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ProfilePicture(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            size: 28,
                            color: Color.fromRGBO(250, 250, 250, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${userData['First Name']} ${userData['Last Name']}',
                    style: fontDefault(
                      secondaryColor(1),
                      FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Birthdate',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    '${userData['Birthdate']}',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gender',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    '${userData['Gender']}',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    '${userData['Address']}',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    '${userData['Email']}',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone Number',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    '${userData['Phone Number']}',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    '${userData['Username']}',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: fontSecondary(secondaryColor(.4), FontWeight.w500),
                  ),
                  Text(
                    '************',
                    style: fontDefault(secondaryColor(1), FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future deleteUser(String id) async {
    final docUser = FirebaseFirestore.instance.collection('User').doc(id);
    docUser.delete();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Theme(
      data: Theme.of(context).copyWith(
        dividerTheme: const DividerThemeData(
          space: 0.0,
          color: Colors.transparent,
        ),
      ),
      child: Scaffold(
        backgroundColor: primaryColor(1),
        appBar: AppBar(
          title: Text(
            'Profile',
            style: fontTertiary(secondaryColor(1), FontWeight.bold),
          ),
          centerTitle: true,
          surfaceTintColor: primaryColor(1),
          backgroundColor: primaryColor(1),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Container(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((_) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => Authenticator()),
                      );
                    }).catchError((error) {
                      print("Error during logout: $error");
                    });
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 32,
                    color: secondaryColor(1),
                  ),
                ))
          ],
        ),
        body: accountProfile(user),
        persistentFooterButtons: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Button(
                  btnLabel: "Edit Profile",
                  onPressedMethod: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => EditProfile(),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  onPressed: () async {
                    // Show a confirmation dialog
                    bool confirmDelete = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Delete Account'),
                          content: const Text(
                              'Are you sure you want to delete your account? This action cannot be undone.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(false); // Cancel
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(true); // Confirm
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );

                    // If the user confirms the deletion, delete the account and data
                    if (confirmDelete == true) {
                      try {
                        // Get the currently signed-in user
                        User? user = FirebaseAuth.instance.currentUser;

                        // Delete the user document in Firestore
                        if (user != null) {
                          await FirebaseFirestore.instance
                              .collection('User')
                              .doc(user.uid)
                              .delete();
                        }

                        // Delete the user account
                        await user?.delete();

                        // Sign out the user
                        await FirebaseAuth.instance.signOut();

                        // Navigate to a screen after deletion (e.g., sign-in or home)
                        // Replace this with your desired destination.
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => StartPage(),
                          ),
                        );
                      } catch (e) {
                        print('Error deleting account: $e');
                        // Handle error, show a snackbar, or display an error message to the user.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error deleting account: $e'),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    'Delete Account',
                    style: fontTertiary(deleteColor(1), FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
