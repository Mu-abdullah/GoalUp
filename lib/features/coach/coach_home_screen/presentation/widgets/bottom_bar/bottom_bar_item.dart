import 'package:flutter/material.dart';

import '../../../../../../core/style/color/app_color.dart';
import '../../../../../../core/style/statics/app_statics.dart';

class BottomBarItem extends StatefulWidget {
  const BottomBarItem({
    super.key,

    required this.icon,
    required this.isSelected,
    required this.onTap,
    this.animationCurve = Curves.easeInOut,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Curve animationCurve;

  @override
  State<BottomBarItem> createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<BottomBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
  }

  @override
  void didUpdateWidget(BottomBarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              padding: AppPadding.smallPadding,
              decoration: BoxDecoration(
                color:
                    widget.isSelected
                        ? AppColors.white.withValues(alpha: 0.2)
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: SlideTransition(
                position: _slideAnimation,
                child: Transform.scale(
                  scale: widget.isSelected ? _scaleAnimation.value : 1.0,
                  child: Row(
                    spacing: 4,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: widget.animationCurve,
                        padding:
                            widget.isSelected
                                ? AppPadding.smallPadding / 2
                                : const EdgeInsets.all(0),

                        child: Icon(
                          widget.icon,
                          color: AppColors.white.withValues(
                            alpha: _opacityAnimation.value,
                          ),
                          size: widget.isSelected ? 24 : 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
