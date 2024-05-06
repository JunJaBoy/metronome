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
            Flexible(
              child: _BpmCounter(
                targetBeat: widget.selectedBeat,
                beatCount: widget.beatCount,
              ),
            ),
            _BpmConfiguration(
              bpm: widget.selectedBpm,
              minimumBpm: widget.minimumBpm,
              maximumBpm: widget.maximumBpm,
              onBpmChanged: (value) => widget.onChangeSelectedBpm(value),
            ),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}

class _BpmCounter extends StatelessWidget {
  final int targetBeat;
  final int? beatCount;

  const _BpmCounter({
    required this.targetBeat,
    required this.beatCount,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: targetBeat,
      itemBuilder: (BuildContext context, int index) {
        final bool selected = beatCount == index + 1;
        return SizedBox(
          width: 64,
          height: 128,
          child: Text(
            "${index + 1}",
            style: TextStyle(fontSize: selected ? 128 : 64),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 32);
      },
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$bpm BPM",
                style: const TextStyle(
                  fontSize: 32,
                ),
              ),
              IconButton(
                onPressed: () {
                  onBpmChanged(bpm - 1);
                },
                icon: const Icon(Icons.arrow_downward_rounded),
              ),
              IconButton(
                onPressed: () {
                  onBpmChanged(bpm + 1);
                },
                icon: const Icon(Icons.arrow_upward_rounded),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Slider(
            value: bpm / maximumBpm,
            min: minimumBpm / maximumBpm,
            onChanged: (value) => onBpmChanged((value * maximumBpm).toInt()),
          ),
        ),
      ],
    );
  }
}
