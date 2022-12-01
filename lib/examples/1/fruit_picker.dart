import 'package:flutter/material.dart';

import 'package:flutter_animations_showcase/common/common.dart';
import 'package:flutter_animations_showcase/examples/1/fruit_item.dart';

/// Built-in Implicit Animations Example
class FruitPicker extends StatefulWidget {
  const FruitPicker({super.key});

  @override
  State<FruitPicker> createState() => _FruitPickerState();
}

class _FruitPickerState extends State<FruitPicker> {
  Fruit _selectedFruit = Fruit.apple;

  void _selectFruit(Fruit fruit) {
    setState(() => _selectedFruit = fruit);
  }

  @override
  Widget build(BuildContext context) {
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
