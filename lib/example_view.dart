import 'package:flutter/material.dart';

import 'package:flutter_animations_showcase/examples/1/fruit_picker.dart';

class ExamplePickerView extends StatelessWidget {
  const ExamplePickerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            _buildTitle(context),
            _buildSubtitle(context),
            const Spacer(),
            const FruitPicker(),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Flutter Animations',
          textAlign: TextAlign.center,
          style: theme.displaySmall,
        ),
      ],
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'and how to use them in your app',
          textAlign: TextAlign.center,
          style: theme.titleLarge,
        ),
      ],
    );
  }
}
