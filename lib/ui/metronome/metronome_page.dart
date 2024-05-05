import 'package:flutter/material.dart';

class MetronomePage extends StatefulWidget {
  final int totalBeat;
  final Stream<int> beatStream;

  const MetronomePage({
    super.key,
    required this.totalBeat,
    required this.beatStream,
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
            SizedBox(
              width: 400,
              height: 400,
              child: Container(
                color: Colors.red,
              ),
            ),
            Container(
              child: _BpmCounter(
                totalBeat: widget.totalBeat,
                beatStream: widget.beatStream,
                bpm: 68,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BpmCounter extends StatelessWidget {
  final int totalBeat;
  final Stream<int> beatStream;
  final int bpm;

  const _BpmCounter({
    super.key,
    required this.totalBeat,
    required this.beatStream,
    required this.bpm,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: beatStream,
        builder: (context, snapshot) {
          return ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: totalBeat,
            itemBuilder: (BuildContext context, int index) {
              final bool selected = snapshot.data == index + 1;
              return Text(
                "${index + 1}",
                style: TextStyle(fontSize: selected ? 128 : 64),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 20);
            },
          );
        },
      ),
    );
  }
}
