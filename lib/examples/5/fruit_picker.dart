import 'package:flutter/material.dart';

import 'package:flutter_animations_showcase/common/common.dart';
import 'package:flutter_animations_showcase/examples/5/fruit_item.dart';

/// AnimatedWidget Explicit Animations Example
class FruitPicker extends StatefulWidget {
  const FruitPicker({super.key});

  @override
  State<FruitPicker> createState() => _FruitPickerState();
}

class _FruitPickerState extends State<FruitPicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  Fruit _selectedFruit = Fruit.apple;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _animation = Tween(begin: .0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.decelerate),
    );

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectFruit(Fruit fruit) {
    setState(() => _selectedFruit = fruit);
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = _selectedFruit.color;

    return GradientTransition(
      animation: _animation,
      color: selectedColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: _buildItems(),
      ),
    );
  }

  Widget _buildItems() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final fruit in Fruit.values)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FruitItem(
              fruit: fruit,
              onFruitPicked: _selectFruit,
              isSelected: fruit == _selectedFruit,
            ),
          ),
      ],
    );
  }
}

class GradientTransition extends AnimatedWidget {
  final Animation<double> animation;
  final Color color;
  final Widget child;

  const GradientTransition({
    super.key,
    required this.animation,
    required this.color,
    required this.child,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(.4)),
        gradient: LinearGradient(
          colors: [
            color.withOpacity(.1),
            color.withOpacity(.5),
            color.withOpacity(.1),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0, animation.value, 1],
        ),
      ),
      child: child,
    );
  }
}
