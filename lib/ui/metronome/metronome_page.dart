import 'package:flutter/material.dart';

class MetronomePage extends StatefulWidget {
  const MetronomePage({super.key});

  @override
  State<MetronomePage> createState() => _MetronomePageState();
}

class _MetronomePageState extends State<MetronomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                beat: 4,
                bpm: 68,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BpmCounter extends StatefulWidget {
  final int beat;
  final int bpm;

  const _BpmCounter({
    super.key,
    required this.beat,
    required this.bpm,
  });

  @override
  State<_BpmCounter> createState() => _BpmCounterState();
}

class _BpmCounterState extends State<_BpmCounter> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.beat,
        itemBuilder: (BuildContext context, int index) {
          return Text(
            "${index + 1}",
            style: TextStyle(fontSize: 128),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 20);
        },
      ),
    );
  }
}
