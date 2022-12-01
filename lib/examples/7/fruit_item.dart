import 'package:flutter/material.dart';

import 'package:flutter_animations_showcase/common/common.dart';

typedef OnFruitPicked = void Function(Fruit);

class FruitItem extends StatefulWidget {
  final Fruit fruit;
  final bool isSelected;
  final double size;
  final OnFruitPicked? onFruitPicked;

  // We add these
  final int itemsCount;
  final int itemIndex;

  const FruitItem({
    super.key,
    required this.fruit,
    required this.itemsCount,
    required this.itemIndex,
    this.onFruitPicked,
    this.size = 70,
    this.isSelected = false,
  });

  @override
  State<FruitItem> createState() => _FruitItemState();
}

class _FruitItemState extends State<FruitItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    //  Time              0     .33     .66     1
    //
    //  Apple scale      -----------------------
    //  Peach scale              ---------------
    //  Kiwi scale                       -------
    
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          widget.itemIndex / widget.itemsCount,
          1,
          curve: Curves.ease,
        ),
      ),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(milliseconds: 500);
    const curve = Curves.ease;

    final color = widget.fruit.color;
    final backgroundColor = widget.isSelected ? color : color.withOpacity(.2);
    final borderRadius = widget.isSelected ? 24.0 : 8.0;

    return ScaleTransition(
      scale: _animation,
      child: GestureDetector(
        onTap: widget.onFruitPicked != null
            ? () => widget.onFruitPicked!(widget.fruit)
            : null,
        child: AnimatedContainer(
          height: widget.size,
          width: widget.size,
          duration: animationDuration,
          curve: curve,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: backgroundColor,
          ),
          child: Center(child: _buildEmoji()),
        ),
      ),
    );
  }

  Widget _buildEmoji() {
    return Text(
      widget.fruit.emoji,
      style: const TextStyle(fontSize: 32),
    );
  }
}
