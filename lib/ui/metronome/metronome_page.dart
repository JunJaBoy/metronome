import 'package:flutter/material.dart';

class MetronomePage extends StatefulWidget {
  final int targetBeat;
  final int? currentBeat;

  const MetronomePage({
    super.key,
    required this.targetBeat,
    required this.currentBeat,
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
        child: _BpmCounter(
          targetBeat: widget.targetBeat,
          currentBeat: widget.currentBeat,
          // TODO
          bpm: 68,
        ),
      ),
    );
  }
}

class _BpmCounter extends StatelessWidget {
  final int targetBeat;
  final int? currentBeat;
  final int bpm;

  const _BpmCounter({
    super.key,
    required this.targetBeat,
    required this.currentBeat,
    required this.bpm,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: targetBeat,
      itemBuilder: (BuildContext context, int index) {
        final bool selected = currentBeat == index + 1;
        return Text(
          "${index + 1}",
          style: TextStyle(fontSize: selected ? 128 : 64),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 20);
      },
    );
  }
}
