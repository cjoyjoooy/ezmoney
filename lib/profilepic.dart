import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezmoney/models/appstyle.dart';
import 'package:ezmoney/models/buttonStyle.dart';
import 'package:ezmoney/models/buttonStyle3.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'photo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String urlFile = "";

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  Widget imgExist() => Image.file(
        File(pickedFile!.path!),
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
      );

  Widget imgNotExist() => Image.asset(
        'images/no-image.png',
        fit: BoxFit.cover,
      );

  String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  Future uploadFile(context) async {
    showLoaderDialog(context);

    final path = 'images/${'${generateRandomString(5)}-${pickedFile!.name}'}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download Link: $urlDownload');

    updateDatabase(urlDownload, context);
    // setState(() {
    //   urlFile = urlDownload;
    //   uploadTask = null;
    //   Navigator.pop(context);
    // });
  }

  showAlertDialogUpload(BuildContext context) {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text("Cancel"),
    );

    Widget continueButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
        uploadFile(context);
      },
      child: const Text("Continue"),
    );

    AlertDialog alert = AlertDialog(
      title: const Text('Question'),
      content: const Text('Are you sure you want to upload this image?'),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Uploading..."),
          )
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlert(BuildContext context, String title, String msg) {
    Widget continueButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
        if (title == "Success") {
          if (urlFile == '') urlFile = "-";
          Navigator.of(context).pop(Photo(image: urlFile));
        }
      },
      child: const Text('OK'),
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
        stream: uploadTask?.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!;
            double progress = data.bytesTransferred / data.totalBytes;
            return progressBar(progress);
          } else {
            return const SizedBox(
              height: 50,
            );
          }
        },
      );

  Widget progressBar(progress) => SizedBox(
        height: 50,
        child: Stack(
          fit: StackFit.expand,
          children: [
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey,
              color: accentColor(1),
            ),
            Center(
              child: Text(
                '${(100 * progress).roundToDouble()}%',
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );

  Future updateDatabase(urlDownload, context) async {
    final user = FirebaseAuth.instance.currentUser!;
    final docUser = FirebaseFirestore.instance.collection('User').doc(user.uid);

    await docUser.update({
      'Image': urlDownload,
    }).then((value) {
      showAlert(context, "Success", "Image Update Succcess!");
    });
    setState(() {
      pickedFile = null;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor(1),
      appBar: AppBar(
        title: Text(
          "Profile Picture",
          style: fontTertiary(secondaryColor(1), FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          color: accentColor(1),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.grey,
                ),
              ),
              child: Center(
                child: (pickedFile != null) ? imgExist() : imgNotExist(),
              ),
            ),
            Button3(
              btnLabel: "Select Photo",
              iconVal: Icons.add_a_photo,
              onPressedMethod: () {
                selectFile();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Button3(
              btnLabel: "Upload Image",
              iconVal: Icons.upload,
              onPressedMethod: () {
                if (pickedFile != null) {
                  showAlertDialogUpload(context);
                } else {
                  showAlert(context, "Error", "Please select a photo");
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            buildProgress()
          ],
        ),
      ),
    );
  }
}
