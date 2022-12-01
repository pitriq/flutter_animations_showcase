import 'package:flutter/material.dart';

import 'package:flutter_animations_showcase/common/common.dart';
import 'package:flutter_animations_showcase/examples/7/fruit_item.dart';

/// BONUS: Staggered Animations Example
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
        for (final index in Iterable.generate(Fruit.values.length))
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FruitItem(
              fruit: Fruit.values[index],
              onFruitPicked: _selectFruit,
              isSelected: Fruit.values[index] == _selectedFruit,
              itemsCount: Fruit.values.length,
              itemIndex: index,
            ),
          ),
      ],
    );
  }
}
