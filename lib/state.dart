import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'data/data.dart';
import 'package:math_expressions/math_expressions.dart';

class MainState {
  final FlutterTts tts = FlutterTts();
  final KeyData dataset = KeyData();

  var inputControl = ['0', '0', '0', '0', '0', '0'].obs;
  var keyOutput = [].obs;
  var braillerOutput = [].obs;

  RxString brailleText = ''.obs;
  RxString charText = ''.obs;

  RxBool isCharNumber = false.obs;

  void speak(String txt) async {
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
      compute();
    }
    if (braillerOutput.isNotEmpty) {
      braillerOutput.removeLast();
      compute();
    }
    speak(charText.value);
  }

  void reset() {
    charText.value = "";
    brailleText.value = "";
    keyOutput.clear();
    braillerOutput.clear();
    resetInput();
    speak('');
  }

  void compute() {
    String keyOutputText = keyOutput.join("");
    String keyOutputText2 = braillerOutput.join(" ");

    if (isCharNumber.value) {
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

      String translatedText = "";
      for (int i = 0; i < keyOutputText.length; i++) {
        String currentChar = keyOutputText[i];
        if (letterToNumber.containsKey(currentChar)) {
          translatedText += letterToNumber[currentChar]!;
        } else {
          translatedText += currentChar;
        }
      }

      brailleText.value = keyOutputText2;
      charText.value = translatedText;
      speak(charText.value);
      resetInput();
    } else {
      brailleText.value = keyOutputText2;
      charText.value = keyOutputText;
      speak(charText.value);
      resetInput();
    }
  }

  void mathResult() {
    String finaluserinput = charText.value;

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    keyOutput.clear();
    charText.value = eval.toString();
    speak(charText.value);
    keyOutput.add(charText.value);
  }

  void execute() {
    String kunci = inputControl.join();

    if (dataset.data.containsKey(kunci)) {
      String value1 = dataset.data[kunci]["value1"];
      String value2 = dataset.data[kunci]["value2"];

      keyOutput.add(value1);
      braillerOutput.add(value2);

      if (value1 == "#" && value2 == "\u283C") {
        isCharNumber.value = !isCharNumber.value;

        reset();
        resetInput();
      }

      if (value1 == '=' && value2 == "\u2812") {
        mathResult();
        resetInput();
      } else {
        compute();
      }
    }
    resetInput();
  }
}
