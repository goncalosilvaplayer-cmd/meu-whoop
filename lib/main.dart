import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true),
        home: const Home(),
      );
}

// Dados de exemplo. Mais tarde vêm da pulseira por Bluetooth.
class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Hoje')),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          const Text('Dados de exemplo', style: TextStyle(color: Colors.white54)),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [
            Ring('Recovery', '72%', 0.72, Colors.greenAccent),
            Ring('Strain', '11.4', 11.4 / 21, Colors.lightBlueAccent),
            Ring('Sono', '85%', 0.85, Colors.purpleAccent),
          ]),
          const SizedBox(height: 24),
          const Tile('HRV', '68 ms'),
          const Tile('Frequência cardíaca em repouso', '52 bpm'),
          const Tile('Frequência respiratória', '14.8 rpm'),
          const Tile('Horas de sono', '7 h 32 min'),
        ]),
      );
}

class Tile extends StatelessWidget {
  final String label, value;
  const Tile(this.label, this.value, {super.key});
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          title: Text(label),
          trailing: Text(value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
      );
}

class Ring extends StatelessWidget {
  final String label, value;
  final double progress;
  final Color color;
  const Ring(this.label, this.value, this.progress, this.color, {super.key});
  @override
  Widget build(BuildContext context) => Column(children: [
        SizedBox(
          width: 96,
          height: 96,
          child: CustomPaint(
            painter: _RingPainter(progress, color),
            child: Center(
              child: Text(value,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ]);
}

class _RingPainter extends CustomPainter {
  final double p;
  final Color c;
  _RingPainter(this.p, this.c);
  @override
  void paint(Canvas canvas, Size s) {
    final r = Rect.fromLTWH(6, 6, s.width - 12, s.height - 12);
    final base = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..color = Colors.white12;
    final fg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round
      ..color = c;
    canvas.drawArc(r, 0, 2 * pi, false, base);
    canvas.drawArc(r, -pi / 2, 2 * pi * p, false, fg);
  }

  @override
  bool shouldRepaint(covariant _RingPainter o) => o.p != p || o.c != c;
}
