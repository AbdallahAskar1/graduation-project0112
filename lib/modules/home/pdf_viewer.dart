import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_scan_for_solution/style/icon_broken.dart';


class PdfViewer extends StatefulWidget {
  const PdfViewer({Key? key}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null) {
        _fileName = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());

        print('file name $_fileName');
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Please Select File'),
        leading: IconButton(
          icon: Icon(IconBroken.Arrow___Left),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: isLoading
                ? CircularProgressIndicator()
                : TextButton(
                    onPressed: () {
                      pickFile();
                    },
                    child:const Text('Pick File')),
          ),
          // if (PickedFile != null)
            SizedBox(
              height: 300,
              width: 400,
              child: Image.file(fileToDisplay!),
            ),
        ],
      ),
    );
  }

  // void openFile() async{
  //   FilePickerResult? resultFile = await FilePicker.platform.pickFiles();
  //   if(resultFile !=null){
  //     PlatformFile file = resultFile.files.first;
  //     print(file.name);
  //     print(file.bytes);
  //     print(file.extension);
  //     print(file.path);
  //   }else{
  //     //the user cancel the picker
  //     print('*****************************the user canceled the picker*****************************');
  //   }
  // }
  //
  // Widget content (){
  //   return Center(
  //     child: GestureDetector(
  //       onTap: (){
  //         openFile();
  //       },
  //       child: Container(
  //         width: 100,
  //         height: 50,
  //         color: Colors.blue,
  //         child: Center(child: Text('Open File' ,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
  //       ),
  //     ),
  //   );
  // }
}
/*
* Center(
        child: ElevatedButton(onPressed: () async{
          final result = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf', 'doc'],
          );
          if(result !=null){
            final path = result.files.single.path!;
            setState(() {
              pfdFile = File(path);
            });
          }
        }, child: Text('pdf file'))  ,
      ),*/
