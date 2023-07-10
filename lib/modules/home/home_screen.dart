import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_scan_for_solution/modules/favourite/favourite.dart';
import 'package:my_scan_for_solution/modules/home/recognision_api.dart';
import '../../components/components.dart';
import '../../components/constants.dart';
import '../../cubit/cubit.dart';
import '../../cubit/state.dart';
import '../../style/icon_broken.dart';
import '../../text/scan_text.dart';
import '../change_password/change_password.dart';
import '../profile/profile.dart';

String? showenText;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    const name = 'Moh';
    const email = 'moh@gmail.com';
    final userImage = Image.asset(
      'assets/images/scan_image.jpg',
      width: 80,
      height: 80,
      fit: BoxFit.cover,
    );

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          //var cubit = AppCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                titleSpacing: 5,
                title: const Text(
                  "Please Select Question",
                ),
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(IconBroken.Home),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  );
                }),
              ),
              drawer: buildDrawerItems(
                  name: name,
                  email: email,
                  context: context,
                  userImage: userImage),
              body: Center(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Container(
                          margin: const EdgeInsets.all(20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // if there image show it otherwise show below container
                                if (_image == null)
                                  Container(
                                    width: width * 0.9,
                                    height: height * 0.6,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                if (_image != null) Image.file(_image!),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //gallary picker
                                    Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        padding: const EdgeInsets.only(top: 10),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.grey,
                                            shadowColor: Colors.grey[400],
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0)),
                                          ),
                                          onPressed: () {
                                            _pickImage(ImageSource.gallery);
                                          },
                                          // on pressed open gallery to select image and show it
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  IconBroken.Image,
                                                  size: 30,
                                                ),
                                                Text(
                                                  "Gallery",
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.grey[600]),
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                    // camera picker
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      padding: const EdgeInsets.only(top: 10),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.grey,
                                          shadowColor: Colors.grey[400],
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                        ),
                                        onPressed: () {
                                          _pickImage(ImageSource.camera);
                                        },
                                        // on pressed open camera to select image and show it
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                IconBroken.Camera,
                                                size: 30,
                                              ),
                                              Text(
                                                "Camera",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey[600]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20.0),
                                Container(
                                  width: double.infinity,
                                  height: height * 0.085,
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      final recognizedText =
                                          await RecognitionApi.recognizeText(
                                              InputImage.fromFile(
                                                  File(_image!.path)));
                                      setState(() {
                                        showenText = recognizedText;
                                      });
                                      navigateTo(
                                          context, ScanText(text: showenText!));
                                    }, // route to scanned text page
                                    child: const Text(
                                      'ScanText',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                              ])))));
        });
  }

  Drawer buildDrawerItems(
      {required String name,
      required String email,
      required BuildContext context,
      required Image userImage}) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              child: ListView(
                shrinkWrap: true,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(name),
                    accountEmail: Text(email),
                    currentAccountPicture: InkWell(
                      onTap: () => navigateTo(context, ProfileScreen()),
                      //EditImage(),
                      child: CircleAvatar(
                        child: ClipOval(
                          child: userImage,
                        ),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.lightBlueAccent,
                      // the color is until the image loaded
                      // image: DecorationImage(
                      //   image: NetworkImage(
                      //     "https://images2.alphacoders.com/115/115802.jpg",
                      //   ),
                      //   fit: BoxFit.cover,
                      // )
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(IconBroken.Home),
                          title: const Text("Home"),
                          // hoverColor: Colors.grey,
                          onTap: () => navigateTo(context, const HomeScreen()),
                        ),
                        ListTile(
                          leading: const Icon(IconBroken.Profile),
                          title: const Text("Profile"),
                          // hoverColor: Colors.grey,
                          onTap: () => navigateTo(context, ProfileScreen()),
                        ),
                        ListTile(
                          leading: const Icon(IconBroken.Star),
                          title: const Text("History"),
                          onTap: () =>
                              navigateTo(context, const FavouuritePage()),
                        ),
                        ListTile(
                          leading: const Icon(IconBroken.Setting),
                          title: const Text("Settings"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(IconBroken.Lock),
                          title: const Text("Change Password"),
                          onTap: () => navigateTo(context, ChangePassword()),
                        ),
                        ListTile(
                          leading: const Icon(IconBroken.Search),
                          title: const Text("Share"),
                          onTap: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          color: Colors.grey,
                        ),
                        ListTile(
                          leading: const Icon(IconBroken.Logout),
                          title: const Text("Logout"),
                          onTap: () => signOut(context),
                        ),
                      ],
                    ),
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
