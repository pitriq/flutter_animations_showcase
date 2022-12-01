import 'package:flutter/material.dart';

import 'package:flutter_animations_showcase/common/common.dart';
import 'package:flutter_animations_showcase/examples/4/fruit_item.dart';

/// AnimatedBuilder Explicit Animations Example
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

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: selectedColor.withOpacity(.4)),
            gradient: LinearGradient(
              colors: [
                selectedColor.withOpacity(.1),
                selectedColor.withOpacity(.5),
                selectedColor.withOpacity(.1),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0, _animation.value, 1],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: child,
          ),
        );
      },
      child: _buildItems(),
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
