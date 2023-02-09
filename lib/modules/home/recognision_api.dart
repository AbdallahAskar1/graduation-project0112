
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class RecognitionApi {

  static Future<String?> recognizeText(InputImage inputImage) async{
    try{
      final textRecognizer = TextRecognizer() ;
      final recognizedText = await textRecognizer.processImage(inputImage);
      return recognizedText.text;
    }
    catch(e){
      return null;
    }
  }
}