import 'home_view.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/how_to_use_view_cubit/how_to_use_view_cubit.dart';

class HowToUseView extends StatelessWidget {
  const HowToUseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'How to Use RoboCar',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0XFF26A59A),
              ),
            ),
            const SizedBox(height: 20),
            _buildStep(
              number: 1,
              text: 'Make sure Bluetooth and Location are turned ON.',
            ),
            _buildStep(
              number: 2,
              text: 'Tap the Bluetooth icon to scan for available devices.',
            ),
            _buildStep(
              number: 3,
              text: 'Select your RoboCar device from the list to connect.',
            ),
            _buildStep(
              number: 4,
              text:
                  'Use the text or voice command buttons to control your car:\n'
                  '- f: Forward\n'
                  '- b: Backward\n'
                  '- r: Right\n'
                  '- l: Left\n'
                  '- s: Stop\n'
                  '- x: Brake',
            ),
            _buildStep(number: 5, text: 'Enjoy driving your RoboCar safely!'),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0XFF26A59A),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                await context.read<HowToUseViewCubit>().markAsSeen();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeView()),
                );
              },
              child: const Text(
                'Got it!',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep({required int number, required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: const Color(0XFF26A59A),
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
