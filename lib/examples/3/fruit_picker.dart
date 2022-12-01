import 'package:flutter/material.dart';

import 'package:flutter_animations_showcase/common/common.dart';
import 'package:flutter_animations_showcase/examples/3/fruit_item.dart';

/// Built-in Explicit Animations Example
class FruitPicker extends StatefulWidget {
  const FruitPicker({super.key});

  @override
  State<FruitPicker> createState() => _FruitPickerState();
}

class _FruitPickerState extends State<FruitPicker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  Fruit _selectedFruit = Fruit.apple;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = Tween(begin: .95, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.bounceIn,
      ),
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
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Row(
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
      ),
    );
  }
}
