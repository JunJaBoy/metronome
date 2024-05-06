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
            _BpmSlider(
              selectedBpm: widget.selectedBpm,
              minimumBpm: widget.minimumBpm,
              maximumBpm: widget.maximumBpm,
              onChanged: (value) => widget
                  .onChangeSelectedBpm((value * widget.maximumBpm).toInt()),
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

class _BpmSlider extends StatelessWidget {
  final int selectedBpm;
  final int minimumBpm;
  final int maximumBpm;
  final void Function(double) onChanged;

  const _BpmSlider({
    super.key,
    required this.selectedBpm,
    required this.minimumBpm,
    required this.maximumBpm,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("$selectedBpm BPM"),
        Slider(
          value: selectedBpm / maximumBpm,
          min: minimumBpm / maximumBpm,
          onChanged: (value) => onChanged(value),
        ),
      ],
    );
  }
}
