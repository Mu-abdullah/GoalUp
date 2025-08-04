import 'package:flutter/material.dart';
import 'package:sport/core/style/statics/app_statics.dart';

import '../../../../../../core/style/widgets/app_text.dart';

class GlobalPageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color activeColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final Color checkMarckColor;
  final Color inactiveColor;
  final double height;
  final double indicatorSize;

  const GlobalPageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.activeColor = Colors.yellow,
    this.activeTextColor = Colors.black,
    this.inactiveTextColor = Colors.blueGrey,
    this.checkMarckColor = Colors.white,
    this.inactiveColor = Colors.grey,
    this.height = 24,
    this.indicatorSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;

    return Padding(
      padding: AppPadding.symmetric(horizontal: 32),
      child: SizedBox(
        height: height,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final stepWidth = constraints.maxWidth / totalPages;

            return Stack(
              children: [
                // Background track
                Container(
                  height: 3,
                  margin: EdgeInsets.only(top: height / 2 - 1.5),
                  decoration: BoxDecoration(
                    color: inactiveColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                // Animated progress
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  left: isRTL ? null : 0,
                  right: isRTL ? 0 : null,
                  width: (currentPage + 1) * stepWidth,
                  child: Container(
                    height: 3,
                    margin: EdgeInsets.only(top: height / 2 - 1.5),
                    decoration: BoxDecoration(
                      color: activeColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                // Step indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(totalPages, (index) {
                    final isActive = index <= currentPage;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutBack,
                      width: indicatorSize,
                      height: indicatorSize,
                      decoration: BoxDecoration(
                        color:
                            isActive
                                ? activeColor
                                : inactiveColor.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              isActive
                                  ? activeColor
                                  : inactiveColor.withValues(alpha: 0.5),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child:
                              isActive
                                  ? Icon(
                                    Icons.check,
                                    size: indicatorSize * 0.7,
                                    color: checkMarckColor,
                                    key: ValueKey('check_$index'),
                                  )
                                  : AppText(
                                    '${index + 1}',
                                    color:
                                        isActive
                                            ? activeTextColor
                                            : inactiveTextColor,
                                    fontSize: indicatorSize * 0.5,
                                    tr: false,
                                    key: ValueKey('text_$index'),
                                  ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
