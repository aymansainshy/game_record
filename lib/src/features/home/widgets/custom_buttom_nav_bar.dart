import 'package:flutter/material.dart';
import 'package:hareeg/src/theme/app_theme.dart';

class BottomNavItem {
  final IconData icon;
  final String label;

  BottomNavItem(this.icon, this.label);
}

class CBottomNavigationBar extends StatefulWidget {
  const CBottomNavigationBar({
    super.key,
    required this.bottomNavItems,
    required this.onTap,
    required this.pageIndex,
  });

  final List<BottomNavItem> bottomNavItems;
  final int pageIndex;
  final Function(int) onTap;

  @override
  State<CBottomNavigationBar> createState() => _CBottomNavigationBarState();
}

class _CBottomNavigationBarState extends State<CBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return SizedBox(
      height: 65,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: mediaQuery.width,
            height: 65,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, -1), // changes the shadow position
                ),
              ],
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            left: (mediaQuery.width / 2) * widget.pageIndex * 1,
            child: Container(
              width: mediaQuery.width / 2,
              height: 55,
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColorHex,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(2, (index) {
              return GestureDetector(
                onTap: () => widget.onTap(index),
                child: Container(
                  width: mediaQuery.width / 2.3,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        widget.bottomNavItems[index].icon,
                        size: widget.pageIndex == index ? 20 : 18,
                        color: widget.pageIndex == index ? Colors.white : Colors.grey,
                      ),
                      Text(
                        widget.bottomNavItems[index].label,
                        style: TextStyle(
                          color: widget.pageIndex == index ? Colors.white : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
