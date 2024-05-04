import 'package:flutter/material.dart';
import 'package:metronome/ui/metronome/metronome_page.dart';

void main() {
  runApp(const MetronomeApp());
}

class MetronomeApp extends StatefulWidget {
  const MetronomeApp({super.key});

  @override
  State<MetronomeApp> createState() => _MetronomeAppState();
}

class _MetronomeAppState extends State<MetronomeApp> {
  var isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                isPlaying = !isPlaying;
              },
            );
          },
          child:
              Icon(isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded),
        ),
        body: const MetronomePage(),
      ),
    );
  }
}
