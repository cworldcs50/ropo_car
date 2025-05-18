import 'dart:developer';
import '../cubits/voice_command_cubit/voice_command_states.dart';
import '../widgets/custom_form.dart';
import '../widgets/custom_button.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bluetooth_car/helpers/show_snack_bar.dart';
import '../cubits/voice_command_cubit/voice_command_cubit.dart';
import '../cubits/connect_to_bluetooth_cubit/connect_to_bluetooth_cubit.dart';

class OptionsView extends StatelessWidget {
  const OptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final connectCubit = context.read<ConnectToBluetoothCubit>();

    return BlocProvider(
      create: (context) => VoiceCommandCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                CustomButton(
                  icon: Icons.text_fields,
                  onTap: () {
                    showModalBottomSheet(
                      constraints: BoxConstraints(maxHeight: 300),
                      context: context,
                      builder:
                          (ctx) => CustomForm(
                            onSaved: (command) async {
                              try {
                                await connectCubit.sendCommand(command!);
                              } catch (e) {
                                log("Error sending command: $e");
                                context.showSnackBar("Error sending command");
                              }
                            },
                          ),
                    );
                  },
                ),
                Spacer(),
                BlocListener<VoiceCommandCubit, VoiceCommandState>(
                  listenWhen: (previous, current) => previous != current,
                  listener: (context, state) {
                    if (state is VoiceCommandRecognized) {
                      showCommand(context, command: state.command!);
                    } else {
                      context.showSnackBar("Voice Not Recognized!");
                    }
                  },
                  child: Builder(
                    builder: (context) {
                      return CustomButton(
                        icon: Icons.record_voice_over,
                        onTap: () async {
                          context.showSnackBar("Speak: ");
                          await context
                              .read<VoiceCommandCubit>()
                              .listenAndSendCommand((command) async {
                                try {
                                  await connectCubit.sendCommand(command);
                                } catch (e) {
                                  log("Voice command error: $e");
                                  context.showSnackBar("Voice command failed");
                                }
                              });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showCommand(BuildContext context, {required String command}) {
    switch (command) {
      case 'f':
        context.showSnackBar("Forward");
        break;
      case 'b':
        context.showSnackBar("Backward");
        break;
      case 'r':
        context.showSnackBar("Right");
        break;
      case 'l':
        context.showSnackBar("Left");
        break;
      case 's':
        context.showSnackBar("Stop");
        break;
      case 'x':
        context.showSnackBar("Brake");
        break;
      default:
        context.showSnackBar("Command Not Found!");
    }
  }
}
