
import 'dart:ui';

enum Fruit {
  apple,
  peach,
  kiwi;

  String get emoji {
    switch (this) {
      case Fruit.apple:
        return '🍎';
      case Fruit.peach:
        return '🍑';
      case Fruit.kiwi:
        return '🥝';
    }
  }

  Color get color {
    switch (this) {
      case Fruit.apple:
        return const Color(0xFFE67A97);
      case Fruit.peach:
        return const Color(0xFFF8A476);
      case Fruit.kiwi:
        return const Color(0xFFD1DE92);
    }
  }
}
