import 'package:flutter/material.dart';

import 'package:flutter_animations_showcase/common/common.dart';

typedef OnFruitPicked = void Function(Fruit);

class AnimatedFruitItem extends StatefulWidget {
  final Fruit fruit;
  final bool isSelected;
  final double size;
  final OnFruitPicked? onFruitPicked;

  const AnimatedFruitItem({
    super.key,
    required this.fruit,
    this.onFruitPicked,
    this.size = 70,
    this.isSelected = false,
  });

  @override
  State<AnimatedFruitItem> createState() => _AnimatedFruitItemState();
}

class _AnimatedFruitItemState extends State<AnimatedFruitItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Decoration> _decorationAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      value: widget.isSelected ? 1 : 0,
    );

    //  Time                0     .33     .66     1
    //
    //  Scale               ----------------
    //  Color               ----------------
    //  Rotation                        -----------

    _setUpScaleAnimation();
    _setUpDecorationAnimation();
    _setUpRotationAnimation();
  }

  void _setUpScaleAnimation() {
    final tween = Tween(begin: 1.0, end: 1.2);
    _scaleAnimation = tween.animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, .66, curve: Curves.ease),
      ),
    );
  }

  void _setUpDecorationAnimation() {
    final borderRadius = BorderRadius.circular(24);
    final color = widget.fruit.color.withOpacity(.4);
    final activeColor = widget.fruit.color;

    final tween = DecorationTween(
      begin: BoxDecoration(color: color, borderRadius: borderRadius),
      end: BoxDecoration(color: activeColor, borderRadius: borderRadius),
    );

    _decorationAnimation = tween.animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, .66, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  void _setUpRotationAnimation() {
    final tween = Tween(begin: .0, end: 1.0);
    _rotationAnimation = tween.animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(.5, 1, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedFruitItem oldWidget) {
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onFruitPicked != null
          ? () => widget.onFruitPicked!(widget.fruit)
          : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: DecoratedBoxTransition(
          decoration: _decorationAnimation,
          child: SizedBox(
            height: widget.size,
            width: widget.size,
            child: Center(
              child: RotationTransition(
                turns: _rotationAnimation,
                child: _buildEmoji(),
              ),
            ),
          ),
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
