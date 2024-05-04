import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/core/bpm/bpm_meter.dart';
import 'package:metronome/ui/bpm_meter_bloc.dart';
import 'package:metronome/ui/metronome/metronome_page.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BpmMeterBloc()),
      ],
      child: const MetronomeApp(),
    ),
  );
}

class MetronomeApp extends StatefulWidget {
  const MetronomeApp({super.key});

  @override
  State<MetronomeApp> createState() => _MetronomeAppState();
}

class _MetronomeAppState extends State<MetronomeApp> {
  BpmMeter bpmMeter = BpmMeter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metronome',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            setState(
              () {
                if (bpmMeter.isPlaying) {
                  bpmMeter.pause();
                } else {
                  bpmMeter.resume();
                }
              },
            );
          },
          child: Icon(
            bpmMeter.isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
          ),
        ),
        body: const MetronomePage(),
      ),
    );
  }
}
