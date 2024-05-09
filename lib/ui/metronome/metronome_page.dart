import 'package:flutter/material.dart';
import 'package:metronome/core/metronome/metronome.dart';

class MetronomePage extends StatefulWidget {
  final int? beatCount;

  final int maximumBpm;
  final int minimumBpm;
  final int selectedBpm;
  final void Function(int) onChangeSelectedBpm;

  final int maximumBeat;
  final int minimumBeat;
  final int selectedBeat;
  final void Function(int) onChangeSelectedBeat;

  const MetronomePage({
    super.key,
    required this.beatCount,
    this.maximumBpm = Metronome.maximumBpm,
    this.minimumBpm = Metronome.minimumBpm,
    required this.selectedBpm,
    required this.onChangeSelectedBpm,
    this.maximumBeat = Metronome.maximumBeat,
    this.minimumBeat = Metronome.minimumBeat,
    required this.selectedBeat,
    required this.onChangeSelectedBeat,
  });

  @override
  State<MetronomePage> createState() => _MetronomePageState();
}

class _MetronomePageState extends State<MetronomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Metronome"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _BpmCounter(
                beat: widget.selectedBeat,
                beatCount: widget.beatCount,
                bpm: widget.selectedBpm,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _BeatConfiguration(
                beat: widget.selectedBeat,
                maximumBeat: widget.maximumBeat,
                minimumBeat: widget.minimumBeat,
                onBeatChanged: (value) => widget.onChangeSelectedBeat(value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: _BpmConfiguration(
                bpm: widget.selectedBpm,
                minimumBpm: widget.minimumBpm,
                maximumBpm: widget.maximumBpm,
                onBpmChanged: (value) => widget.onChangeSelectedBpm(value),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

class _BpmCounter extends StatelessWidget {
  final int beat;
  final int? beatCount;
  final int bpm;

  const _BpmCounter({
    required this.beat,
    required this.beatCount,
    required this.bpm,
  });

  @override
  Widget build(BuildContext context) {
    final bool shouldShowConciseLayout = beat > 4;

    return IntrinsicHeight(
      child: Card(
        elevation: 0.0,
        color: Theme.of(context).colorScheme.primaryContainer,
        child: SizedBox(
          height: 160,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: shouldShowConciseLayout
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "$bpm",
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.black,
                          ),
                          textScaler: TextScaler.noScaling,
                        ),
                        const Text(
                          " BPM",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          textScaler: TextScaler.noScaling,
                        ),
                      ],
                    ),
                    if (!shouldShowConciseLayout)
                      Text(
                        "${beatCount ?? 0}/$beat",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                        textScaler: TextScaler.noScaling,
                      ),
                  ],
                ),
                const Spacer(),
                shouldShowConciseLayout
                    ? Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${beatCount ?? 0}",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 120,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textScaler: TextScaler.noScaling,
                          ),
                          const Text(
                            "/",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 60,
                              color: Colors.grey,
                            ),
                            textScaler: TextScaler.noScaling,
                          ),
                          Text(
                            "$beat",
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 60,
                              color: Colors.grey,
                            ),
                            textScaler: TextScaler.noScaling,
                          ),
                        ],
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: beat,
                        itemBuilder: (BuildContext context, int index) {
                          final bool selected = beatCount == index + 1;
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 64,
                              height: 132,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "${index + 1}",
                                  style: TextStyle(
                                    fontSize: selected ? 120 : 60,
                                    color:
                                        selected ? Colors.black : Colors.grey,
                                    fontWeight: selected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                  textScaler: TextScaler.noScaling,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(width: 8);
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BeatConfiguration extends StatelessWidget {
  final int beat;
  final int maximumBeat;
  final int minimumBeat;
  final void Function(int) onBeatChanged;

  const _BeatConfiguration({
    super.key,
    required this.beat,
    required this.maximumBeat,
    required this.minimumBeat,
    required this.onBeatChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        elevation: 0.0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$beat",
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  const Text(
                    " Beat",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      if (beat > minimumBeat) {
                        onBeatChanged(beat - 1);
                      }
                    },
                    icon: const Icon(Icons.remove_rounded),
                  ),
                  IconButton(
                    onPressed: () {
                      if (beat < maximumBeat) {
                        onBeatChanged(beat + 1);
                      }
                    },
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
            ),
            Slider(
              value: beat / maximumBeat,
              min: minimumBeat / maximumBeat,
              divisions: maximumBeat,
              onChanged: (value) =>
                  onBeatChanged((value * maximumBeat).toInt()),
            ),
          ],
        ),
      ),
    );
  }
}

class _BpmConfiguration extends StatelessWidget {
  final int bpm;
  final int minimumBpm;
  final int maximumBpm;
  final void Function(int) onBpmChanged;

  const _BpmConfiguration({
    required this.bpm,
    required this.minimumBpm,
    required this.maximumBpm,
    required this.onBpmChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        elevation: 0.0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$bpm",
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  const Text(
                    " BPM",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      if (bpm > minimumBpm) {
                        onBpmChanged(bpm - 1);
                      }
                    },
                    icon: const Icon(Icons.remove_rounded),
                  ),
                  IconButton(
                    onPressed: () {
                      if (bpm < maximumBpm) {
                        onBpmChanged(bpm + 1);
                      }
                    },
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
            ),
            Slider(
              value: bpm / maximumBpm,
              min: minimumBpm / maximumBpm,
              onChanged: (value) => onBpmChanged((value * maximumBpm).toInt()),
            ),
          ],
        ),
      ),
    );
  }
}
