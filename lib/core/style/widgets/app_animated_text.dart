import 'dart:async';

import 'package:flutter/material.dart';

import 'app_text.dart';

class AnimatedTextWidget extends StatefulWidget {
  final String text;
  final double fontSize;
  final Duration duration;

  const AnimatedTextWidget({
    super.key,
    required this.text,
    this.duration = const Duration(milliseconds: 500),
    required this.fontSize,
  });

  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget> {
  List<String> _words = [];
  final List<Widget> _animatedWords = [];
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _words = widget.text.split(' ');
    _startAnimation();
  }

  void _startAnimation() {
    _timer = Timer.periodic(widget.duration, (timer) {
      if (_currentIndex < _words.length) {
        setState(() {
          _animatedWords.add(
            _AnimatedWord(
              word: _words[_currentIndex],
              duration: widget.duration,
              fontSize: widget.fontSize,
            ),
          );
          _currentIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: _animatedWords,
    );
  }
}

class _AnimatedWord extends StatefulWidget {
  final String word;
  final Duration duration;
  final double fontSize;

  const _AnimatedWord({
    required this.word,
    required this.duration,
    required this.fontSize,
  });

  @override
  __AnimatedWordState createState() => __AnimatedWordState();
}

class __AnimatedWordState extends State<_AnimatedWord>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: AppText(
          widget.word,
          fontSize: widget.fontSize,
          height: 1.75,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
