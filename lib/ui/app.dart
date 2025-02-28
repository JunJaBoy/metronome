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
  _MetronomeAppDestination _currentDestination =
      _MetronomeAppDestination.metronome;

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
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
              bottomNavigationBar: NavigationBar(
                selectedIndex: _currentDestination.index,
                onDestinationSelected: (index) {
                  setState(
                    () {
                      _currentDestination = index.destination;
                    },
                  );
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.music_note_outlined),
                    label: "Metronome",
                    selectedIcon: Icon(Icons.music_note_rounded),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.search_outlined),
                    label: "Search BPM",
                    selectedIcon: Icon(Icons.search_rounded),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.library_books_outlined),
                    label: "Library",
                    selectedIcon: Icon(Icons.library_books_rounded),
                  ),
                ],
              ),
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
                  switch (_currentDestination) {
                    case _MetronomeAppDestination.metronome:
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
                    case _MetronomeAppDestination.searchBpm:
                    // TODO: Handle this case.
                    case _MetronomeAppDestination.library:
                    // TODO: Handle this case.
                    default:
                  }
                  return const Center();
                },
              ),
            ),
          ),
        ),
      );
}

enum _MetronomeAppDestination {
  metronome,
  searchBpm,
  library,
  ;
}

extension _MetronomeAppDestinationIndex on _MetronomeAppDestination {
  int get index {
    switch (this) {
      case _MetronomeAppDestination.metronome:
        return 0;
      case _MetronomeAppDestination.searchBpm:
        return 1;
      case _MetronomeAppDestination.library:
        return 2;
    }
  }
}

extension _MetronomeAppDestinationFromIndex on int {
  _MetronomeAppDestination get destination {
    switch (this) {
      case 0:
        return _MetronomeAppDestination.metronome;
      case 1:
        return _MetronomeAppDestination.searchBpm;
      case 2:
        return _MetronomeAppDestination.library;
      default:
        throw StateError("Illegal state for converting index to destination.");
    }
  }
}
