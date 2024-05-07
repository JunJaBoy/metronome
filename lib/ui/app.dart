import 'package:audioplayers/audioplayers.dart';
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
  final metronomeBloc = MetronomeBloc();

  var _recent = -1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MetronomeBloc()),
      ],
      child: BlocBuilder<MetronomeBloc, Metronome>(
        bloc: metronomeBloc,
        builder: (context, metronome) => MaterialApp(
          title: 'Metronome',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
            useMaterial3: true,
          ),
          home: Scaffold(
            floatingActionButton: FloatingActionButton.large(
              onPressed: () {
                setState(
                  () {
                    metronomeBloc.add(
                      metronome.isPlaying
                          ? PauseMetronome()
                          : ResumeMetronome(),
                    );
                  },
                );
              },
              child: Icon(
                metronome.isPlaying
                    ? Icons.stop_rounded
                    : Icons.play_arrow_rounded,
              ),
            ),
            body: StreamBuilder(
              stream: metronome.beatStream,
              builder: (context, beat) {
                if (beat.data != null) {
                  AudioPlayer().play(
                    AssetSource(
                      beat.data == Metronome.minimumBeat
                          ? 'audio_metronome_bell.mp3'
                          : 'audio_metronome_click.mp3',
                    ),
                    mode: PlayerMode.lowLatency,
                  );
                }
                if (beat.data != _recent && beat.data != null) {
                  _recent = beat.data!;
                }
                return MetronomePage(
                  beatCount: beat.data,
                  selectedBpm: metronome.properties.bpm,
                  selectedBeat: metronome.properties.beat,
                  onChangeSelectedBpm: (value) {
                    setState(
                      () {
                        metronomeBloc.add(ChangeMetronomeBpm(value));
                      },
                    );
                  },
                  onChangeSelectedBeat: (value) {
                    setState(
                      () {
                        metronomeBloc.add(ChangeMetronomeBeat(value));
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
