import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_scan_for_solution/modules/favourite/favourite.dart';
import 'package:my_scan_for_solution/modules/home/pdf_viewer.dart';
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
  File? pfdFile;
  Future _PickImage(ImageSource source) async {
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
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
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
          drawer: const NavigationDrawer(),
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
                        width: 600,
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[300]!,
                        ),
                      ),
                    if (_image != null) Image.file(_image!),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //file picker
                         Container(
                           margin: const EdgeInsets.symmetric(horizontal: 5),
                           padding: const EdgeInsets.only(top: 10),
                           child: ElevatedButton(
                             style: ElevatedButton.styleFrom(
                               backgroundColor: Colors.white,
                               foregroundColor: Colors.grey,
                               shadowColor: Colors.grey[400],
                               elevation: 10,
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(8.0)),
                             ),
                             onPressed: () {
                               Navigator.of(context).push(MaterialPageRoute(builder: (_) =>const PdfViewer()));
                             }, // on pressed open pdf page to select file .pdf
                             child: Container(
                               margin: const EdgeInsets.symmetric(
                                   vertical: 5, horizontal: 5),
                               child: Column(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   const Icon(
                                     IconBroken.Folder,
                                     size: 30,
                                   ),
                                   Text(
                                     "File",
                                     style: TextStyle(
                                         fontSize: 13, color: Colors.grey[600]),
                                   )
                                 ],
                               ),
                             ),
                           ),
                         ),
                        //gallary picker
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.grey,
                              shadowColor: Colors.grey[400],
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            onPressed: () {
                              _PickImage(ImageSource.gallery);
                            }, // on pressed open gallery to select image and show it
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
                                        fontSize: 13, color: Colors.grey[600]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        //const SizedBox(
                          //width: 20.0,
                        //),
                        // camera picker
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.grey,
                              shadowColor: Colors.grey[400],
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            onPressed: () {
                              _PickImage(ImageSource.camera);
                            }, // on pressed open camera to select image and show it
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
                                        fontSize: 13, color: Colors.grey[600]),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
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
                                  InputImage.fromFile(File(_image!.path)));
                          setState(() {
                            showenText = recognizedText;
                          });
                          navigateTo(context, ScanText(text: showenText!));
                        }, // route to scanned text page
                        child: const Text(
                          'ScanText',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

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
                    accountName: const Text(name),
                    accountEmail: const Text(email),
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
                          title: const Text("Favorite"),
                          onTap: () =>
                              navigateTo(context, const FavouuritePage()),
                        ),
                        ListTile(
                          leading: const Icon(IconBroken.Setting),
                          title: const Text("Settings"),
                          onTap: () {},
                        ),
                        ListTile(
                          leading:const Icon(IconBroken.Lock),
                          title:const Text("Change Password"),
                          onTap: () => navigateTo(context, ChangePassword()),
                        ),
                        ListTile(
                          leading:const Icon(IconBroken.Search),
                          title:const Text("Share"),
                          onTap: () {},
                        ),
                       const SizedBox(
                          height: 20,
                        ),
                       const Divider(
                          color: Colors.grey,
                        ),
                        ListTile(
                          leading:const Icon(IconBroken.Logout),
                          title:const Text("Logout"),
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

Widget editImage({name, image}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(name),
      centerTitle: true,
    ),
    body: Column(
      children: [
        Image.asset(
          image,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ],
    ),
  );
}


/* return Drawer(
       child: SingleChildScrollView(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             Material(
               color: Colors.blue.shade700,
               child: Container(
                 padding: EdgeInsets.only(top: 24 + MediaQuery.of(context).padding.top,bottom: 24),
               child: Column(
                 children: [
                   CircleAvatar(
                     radius: 52,
                     backgroundImage: AssetImage('assets/images/scan_image.jpg'),
                   ),
                   SizedBox(
                     height: 12,
                   ),
                   Text(
                     'Mohamed Ahmed',
                     style: TextStyle(
                         fontSize: 15,
                         color: Colors.white
                     ),
                   ),
                   Text(
                     'mmekawy48@...',
                     style: TextStyle(
                         fontSize: 10,
                         color: Colors.white
                     ),
                   ),
                 ],
               ),
               ),

             ),
             buildMenuItem(context)
           ],
         ),
       ),
     );*/

/*Widget buildMenuItem(BuildContext context) => Container(
     padding: EdgeInsets.all(24),
     child: Wrap(
       runSpacing: 16,
       children: [
         ListTile(
           onTap: (){
             navigateTo(context, ProfileScreen());
           },
           leading: Icon(IconBroken.User),
           title: Text(
             'My Profile'
           ),
         ),
         Container(
           height: 30,
           width: double.infinity,
           decoration: BoxDecoration(
               color: Colors.grey[300],
               borderRadius: BorderRadius.circular(6)
           ),
           child: Row(
             children: [
               Expanded(
                 child: Text(
                     'Setting'
                 ),
               ),
               Icon(IconBroken.Arrow___Down_2)
             ],
           ),
         ),
         ListTile(
           onTap: (){
             navigateTo(context, HomeScreen());
           },
           leading: Icon(IconBroken.Home),
           title: Text(
               'Home'
           ),
         ),
         ListTile(
           onTap: (){
             navigateTo(context, ChangePassword());
             },
           leading: Icon(IconBroken.Lock),
           title: Text(
               'Change Password'
           ),
         ),
         ListTile(
           onTap: (){
           },
           leading: Icon(IconBroken.User1),
           title: Text(
               'About Us'
           ),
         ),
         SizedBox(
          height: 120,
        ),
         ListTile(
           onTap: (){

                 signOut(context);

           },
           leading: Icon(IconBroken.Logout),
           title: Text(
               'SIGN OUT'
           ),
         ),
       ],
     ),
   );
 }*/
/*
 * profile
 * settings
 * home  //**//**//
 * change password
 * about us
 * sign out  //**//**//
 * */



//
// Center(
// child: SingleChildScrollView(
// physics: BouncingScrollPhysics(),
// child: Container(
// margin: const EdgeInsets.all(20),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// if ( cubit.PickImage() == null)
// Container(
// width: 600,
// height: 400,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(20),
// color: Colors.grey[300]!,
// ),
// ),
// if (cubit.imageFile != null) Expanded(child: Image.file(File(cubit.imageFile!.path))),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Container(
// margin: const EdgeInsets.symmetric(horizontal: 5),
// padding: const EdgeInsets.only(top: 10),
// child: ElevatedButton(
// style: ElevatedButton.styleFrom(
// primary: Colors.white,
// onPrimary: Colors.grey,
// shadowColor: Colors.grey[400],
// elevation: 10,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8.0)),
// ),
// onPressed: () {
// cubit.getImage(ImageSource.gallery);
// },
// child: Container(
// margin: const EdgeInsets.symmetric(
// vertical: 5, horizontal: 5),
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Icon(
// IconBroken.Image,
// size: 30,
// ),
// Text(
// "Gallery",
// style: TextStyle(
// fontSize: 13, color: Colors.grey[600]),
// )
// ],
// ),
// ),
// )),
// SizedBox(
// width: 20,
// ),
// Container(
// margin: const EdgeInsets.symmetric(horizontal: 5),
// padding: const EdgeInsets.only(top: 10),
// child: ElevatedButton(
// style: ElevatedButton.styleFrom(
// primary: Colors.white,
// onPrimary: Colors.grey,
// shadowColor: Colors.grey[400],
// elevation: 10,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(8.0)),
// ),
// onPressed: () {
// cubit.getImage(ImageSource.camera);
// },
// child: Container(
// margin: const EdgeInsets.symmetric(
// vertical: 5, horizontal: 5),
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Icon(
// IconBroken.Camera,
// size: 30,
// ),
// Text(
// "Camera",
// style: TextStyle(
// fontSize: 13, color: Colors.grey[600]),
// )
// ],
// ),
// ),
// )),
// ],
// ),
// const SizedBox(
// height: 20,
// ),
// Container(
// width: double.infinity,
// height: 60,
// decoration: BoxDecoration(
// color: Colors.blue,
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(12),
// bottomRight: Radius.circular(12),
// ),
// ),
// child: OutlinedButton(
// onPressed: (){
// Navigator.push(context, MaterialPageRoute(builder: (context) => ScanText(
// text: cubit.scannedText,
// ),
// )
// );},
// child: Text(
// 'ScanText',style: TextStyle(
// color: Colors.white,
// fontSize: 20
// ),
// ),
// )
// ),
// ],
// )
// ),
// )
// ),