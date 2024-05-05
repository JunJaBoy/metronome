import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome/core/metronome/metronome.dart';
import 'package:metronome/ui/bloc/metronome_bloc.dart';
import 'package:metronome/ui/metronome/metronome_page.dart';

class MetronomeApp extends StatefulWidget {
  const MetronomeApp({super.key});

  @override
  State<MetronomeApp> createState() => _MetronomeAppState();
}

class _MetronomeAppState extends State<MetronomeApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MetronomeBloc()),
      ],
      child: BlocBuilder<MetronomeBloc, Metronome>(
        builder: (context, metronome) => MaterialApp(
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
                    if (metronome.isPlaying) {
                      metronome.pause();
                    } else {
                      metronome.resume();
                    }
                  },
                );
              },
              child: Icon(
                metronome.isPlaying
                    ? Icons.stop_rounded
                    : Icons.play_arrow_rounded,
              ),
            ),
            body: MetronomePage(
              targetBeat: metronome.properties.targetBeat,
              // TODO Remove stream, use current beat instaed
              beatStream: metronome.beatStream,
            ),
          ),
        ),
      ),
    );
  }
}
