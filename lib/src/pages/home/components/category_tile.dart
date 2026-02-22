import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_colors.dart';

class CategoryTile extends StatelessWidget {
  const CategoryTile({
    super.key,
    required this.categoryyy,
    required this.isSelecteddd,
    required this.onPresseddd,
  });

  final String categoryyy;
  final bool isSelecteddd;
  final VoidCallback onPresseddd;

  @override
  Widget build(BuildContext context) {
    /// Faz que algo(talvez um ícone) seja clicável
    return GestureDetector(
      onTap: onPresseddd,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelecteddd
                ? CustomColors.customSwatchColor
                : Colors.transparent,
          ),
          child: Text(
            categoryyy,
            style: TextStyle(
              color: isSelecteddd
                  ? Colors.white
                  : CustomColors.customContrastColor,
              fontWeight: FontWeight.bold,
              fontSize: isSelecteddd ? 16 : 14,
            ),
          ),
        ),
      ),
    );
  }
}
