class VoiceCommandState {
  const VoiceCommandState();
}

class VoiceCommandInitial extends VoiceCommandState {
  const VoiceCommandInitial();
}

class VoiceCommandRecognized extends VoiceCommandState {
  const VoiceCommandRecognized({required this.command});

  final String? command;
}

class VoiceCommandError extends VoiceCommandState {
  const VoiceCommandError({required this.errorMessage});

  final String errorMessage;
}
