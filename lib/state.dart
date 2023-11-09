import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'data/data.dart';

class MainState {
  final FlutterTts tts = FlutterTts();
  final KeyData dataset = KeyData();

  var inputControl = ['0', '0', '0', '0', '0', '0'].obs;
  var keyOutput = [].obs;
  var braillerOutput = [].obs;

  RxString brailleText = ''.obs;
  RxString charText = ''.obs;

  speak(String txt) async {
    await tts.setLanguage('id-ID');
    await tts.setPitch(1);
    await tts.speak(txt);
  }

  void setInput(int index, String value) {
    inputControl[index] = value;
  }

  void resetInput() {
    inputControl.value = ['0', '0', '0', '0', '0', '0'];
  }

  void backSpace() {
    if (keyOutput.isNotEmpty) {
      keyOutput.removeLast();
      charText.value = keyOutput.join('');
    }
    if (braillerOutput.isNotEmpty) {
      braillerOutput.removeLast();
      brailleText.value = braillerOutput.join('');
    }
    speak(charText.value);
  }

  void resetBar() {
    charText.value = "";
    brailleText.value = "";

    keyOutput.clear();
    braillerOutput.clear();
    resetInput();
    speak('');
  }

  void execute() {
    String kunci = inputControl.join();
    if (dataset.data.containsKey(kunci)) {
      String value1 = dataset.data[kunci]["value1"];
      String value2 = dataset.data[kunci]["value2"];

      keyOutput.add(value1);
      braillerOutput.add(value2);

      computeChar();
      computeBraille();

      // Gabungan karakter Braille saat ini
      // String combinedKey = keyOutput.join("");
      // print(combinedKey);

      // speak(keyOutput.join(txt1)); // Memanggil speak untuk txt1
      // speak(keyOutput.join(txt2));

      speak(charText.value);

      resetInput();
    }
    resetInput();
  }

  //Untuk ngambil karakter braille buat ditampilin
  void computeBraille() {
    String keyOutputText = braillerOutput.join("");
    // String txtGanjil = "";

    // for (int i = 1; i < keyOutputText.length; i += 2) {
    //   txtGanjil += keyOutputText[i];
    // }

    // if (keyData.containsKey("#")) {
    //   txtGanjil = "#" + txtGanjil;
    // }

    brailleText.value = keyOutputText;
  }

  //Untuk ngambil angka awas buat ditampilin
  void computeChar() {
    String keyOutputText = keyOutput.join("");
    String txtGenap = "";

    for (int i = 0; i < keyOutputText.length; i += 2) {
      txtGenap += keyOutputText[i];
    }
    // if (txtGenap.startsWith("#")) {
    //   // Hapus karakter "#" dari awal txtGenap
    //   txtGenap = txtGenap.substring(1);
    if (txtGenap.contains("#")) {
      txtGenap = txtGenap.replaceAll("#", "");
      // Membuat peta pengubahan dari huruf ke angka
      Map<String, String> letterToNumber = {
        "a": "1",
        "b": "2",
        "c": "3",
        "d": "4",
        "e": "5",
        "f": "6",
        "g": "7",
        "h": "8",
        "i": "9",
        "j": "10"
      };

      // Menerjemahkan karakter berurutan ke dalam angka
      String translatedText = "";
      for (int i = 0; i < txtGenap.length; i++) {
        String currentChar = txtGenap[i];
        if (letterToNumber.containsKey(currentChar)) {
          translatedText += letterToNumber[currentChar]!;
        } else {
          // Jika karakter tidak ditemukan dalam peta, biarkan seperti itu
          translatedText += currentChar;
        }
      }

      charText.value = translatedText;
    } else {
      charText.value = keyOutputText;
    }
  }
}
