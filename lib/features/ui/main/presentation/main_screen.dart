import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:protest/common/constants.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.child});

  final StatefulNavigationShell child;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  ValueNotifier<int> pageIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: pageIndex,
        builder: (context, value, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: pageIndex.value,
            unselectedLabelStyle: TextStyle(fontSize: 12),
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            onTap: (value) {
              pageIndex.value = value;
            },
            items: List.from(bottomNavigations)
                .map(
                  (e) => BottomNavigationBarItem(
                    icon: SvgPicture.asset(e.icon),
                    activeIcon: SvgPicture.asset(e.activeIcon),
                    label: e.name,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
