import 'dart:developer';

import 'package:bluetooth_car/helpers/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial_ble/flutter_bluetooth_serial_ble.dart';
import '../widgets/custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/connect_to_bluetooth_cubit/connect_to_bluetooth_cubit.dart';
import '../cubits/connect_to_bluetooth_cubit/connect_to_bluetooth_states.dart';
import 'options_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    context.read<ConnectToBluetoothCubit>().scanForDevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: BlocBuilder<ConnectToBluetoothCubit, ConnectToBluetoothStates>(
          builder: (context, state) {
            return InkWell(
              onTap: () async {
                final ConnectToBluetoothCubit cubit =
                    context.read<ConnectToBluetoothCubit>();
                final List<BluetoothDiscoveryResult> devices =
                    cubit.scannedDevices;
                await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ListView.separated(
                      itemCount: devices.length,
                      separatorBuilder: (_, __) => Divider(),
                      itemBuilder: (context, index) {
                        final BluetoothDiscoveryResult result = devices[index];
                        return ListTile(
                          title: Text(
                            result.device.name ?? "UNKNOWN",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            result.device.address,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onTap: () async {
                            bool connected = await cubit.connectToDevice(
                              result.device,
                            );

                            log(connected.toString());
                            if (connected) {
                              context.showSnackBar("connected");
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => OptionsView(),
                                ),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                );
              },
              child: Icon(Icons.bluetooth, size: 300, color: Color(0XFF26A59A)),
            );
          },
        ),
      ),
    );
  }
}
