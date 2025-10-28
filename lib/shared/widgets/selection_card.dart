import 'package:flutter/material.dart';
import '../../core/theme/color_palette.dart';

class SelectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? emoji;
  final IconData? icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? selectedColor;

  const SelectionCard({
    super.key,
    required this.title,
    this.subtitle,
    this.emoji,
    this.icon,
    required this.isSelected,
    required this.onTap,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected 
              // ignore: deprecated_member_use
              ? (selectedColor ?? ColorPalette.primary).withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
                ? (selectedColor ?? ColorPalette.primary)
                : ColorPalette.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                // ignore: deprecated_member_use
                color: (selectedColor ?? ColorPalette.primary).withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (emoji != null)
              Text(
                emoji!,
                style: const TextStyle(fontSize: 40),
              )
            else if (icon != null)
              Icon(
                icon,
                size: 40,
                color: isSelected 
                    ? (selectedColor ?? ColorPalette.primary)
                    : ColorPalette.textSecondary,
              ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected 
                    ? ColorPalette.textPrimary
                    : ColorPalette.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 12,
                  color: ColorPalette.textSecondary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Icon(
                  Icons.check_circle,
                  color: selectedColor ?? ColorPalette.primary,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Checkbox version for multi-select (problem areas)
class CheckboxSelectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const CheckboxSelectionCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected 
              // ignore: deprecated_member_use
              ? ColorPalette.primary.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? ColorPalette.primary : ColorPalette.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (_) => onTap(),
              activeColor: ColorPalette.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.textPrimary,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: ColorPalette.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}