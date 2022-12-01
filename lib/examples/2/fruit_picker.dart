import 'package:flutter/material.dart';

import 'package:flutter_animations_showcase/common/common.dart';
import 'package:flutter_animations_showcase/examples/2/fruit_item.dart';

/// Custom Implicit Animations Example
class FruitPicker extends StatefulWidget {
  const FruitPicker({super.key});

  @override
  State<FruitPicker> createState() => _FruitPickerState();
}

class _FruitPickerState extends State<FruitPicker> {
  Fruit _selectedFruit = Fruit.apple;
  bool _isDisabled = false;

  void _selectFruit(Fruit fruit) {
    setState(() => _selectedFruit = fruit);
  }

  void _toggleDisabled() {
    setState(() => _isDisabled = !_isDisabled);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnimatedItems(),
        const SizedBox(height: 28),
        _buildToggleButton(),
      ],
    );
  }

  Widget _buildAnimatedItems() {
    const animationDuration = Duration(milliseconds: 500);
    const animationCurve = Curves.easeInOut;

    const filterOnColor = disabled;
    final filterOffColor = disabled.withOpacity(0);
    final colorTween = ColorTween(
      begin: filterOffColor,
      end: _isDisabled ? filterOnColor : filterOffColor,
    );

    return TweenAnimationBuilder(
      duration: animationDuration,
      curve: animationCurve,
      tween: colorTween,
      builder: (context, value, child) {
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            value!,
            BlendMode.srcATop,
          ),
          child: child,
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
              onFruitPicked: _isDisabled ? null : _selectFruit,
              isSelected: _isDisabled ? false : fruit == _selectedFruit,
            ),
          ),
      ],
    );
  }

  Widget _buildToggleButton() {
    final text = _isDisabled ? 'Enable' : 'Disable';
    return ElevatedButton(
      onPressed: _toggleDisabled,
      child: Text(text),
    );
  }
}
