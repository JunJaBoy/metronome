import 'package:flutter/material.dart';
import 'package:metronome/core/metronome/metronome.dart';

class MetronomePage extends StatefulWidget {
  final int? beatCount;

  final int maximumBpm;
  final int minimumBpm;
  final int selectedBpm;

  final int maximumBeat;
  final int minimumBeat;
  final int selectedBeat;

  const MetronomePage({
    super.key,
    required this.beatCount,
    this.maximumBpm = Metronome.maximumBpm,
    this.minimumBpm = Metronome.minimumBpm,
    required this.selectedBpm,
    this.maximumBeat = Metronome.maximumBeat,
    this.minimumBeat = Metronome.minimumBeat,
    required this.selectedBeat,
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
            Slider(
              value: 0.5,
              onChanged: (value) {
                print("SLIDER VALUE $value");
              },
            )
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
    super.key,
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
          width: 60,
          height: 120,
          child: Text(
            "${index + 1}",
            style: TextStyle(fontSize: selected ? 128 : 64),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 20);
      },
    );
  }
}
