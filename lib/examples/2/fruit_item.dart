import 'package:flutter/material.dart';

import 'package:flutter_animations_showcase/common/common.dart';

typedef OnFruitPicked = void Function(Fruit);

class FruitItem extends StatelessWidget {
  final Fruit fruit;
  final bool isSelected;
  final double size;
  final OnFruitPicked? onFruitPicked;

  const FruitItem({
    super.key,
    required this.fruit,
    this.onFruitPicked,
    this.size = 70,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(milliseconds: 500);
    const curve = Curves.ease;

    final color = fruit.color;
    final backgroundColor = isSelected ? color : color.withOpacity(.2);
    final borderRadius = isSelected ? 24.0 : 8.0;

    return GestureDetector(
      onTap: onFruitPicked != null ? () => onFruitPicked!(fruit) : null,
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: backgroundColor,
        ),
        child: Center(child: _buildEmoji()),
      ),
    );
  }

  Widget _buildEmoji() {
    return Text(
      fruit.emoji,
      style: const TextStyle(fontSize: 32),
    );
  }
}
