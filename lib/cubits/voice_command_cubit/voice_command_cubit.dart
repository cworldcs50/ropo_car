import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'voice_command_states.dart';

class VoiceCommandCubit extends Cubit<VoiceCommandState> {
  final stt.SpeechToText _speech = stt.SpeechToText();

  VoiceCommandCubit() : super(VoiceCommandInitial());

  Future<void> listenAndSendCommand(
    Future<void> Function(String command) onCommandRecognized,
  ) async {
    bool available = await _speech.initialize();
    stt.SpeechListenOptions(
      partialResults: true,
      listenMode: stt.ListenMode.confirmation,
    );

    if (available) {
      await _speech.listen(
        onResult: (result) async {
          final spokenText = result.recognizedWords.toLowerCase();
          final command = _mapSpeechToCommand(spokenText);
          if (command != null) {
            await onCommandRecognized(command);

            emit(VoiceCommandRecognized(command: command));
            await stopListening();
          }
        },

        localeId: "en_US",
      );
    } else {
      emit(VoiceCommandError(errorMessage: "Speech recognition unavailable"));
    }
  }

  Future<void> stopListening() async => await _speech.stop();

  String? _mapSpeechToCommand(String input) {
    if (input.contains("forward")) {
      return 'f';
    } else if (input.contains("back") || input.contains("backward")) {
      return 'b';
    } else if (input.contains("left")) {
      return 'l';
    } else if (input.contains("right")) {
      return 'r';
    } else if (input.contains("stop")) {
      return 's';
    } else if (input.contains("brake")) {
      return 'x';
    }
    return null;
  }
}
