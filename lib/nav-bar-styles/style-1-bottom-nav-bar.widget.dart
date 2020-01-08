import 'package:flutter/material.dart';
import '../persistent-tab-view.dart';

class BottomNavStyle1 extends StatelessWidget {
  final int selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final double navBarHeight;
  final bool isIOS;
  final bool isCurved;

  BottomNavStyle1(
      {Key key,
      this.selectedIndex,
      this.showElevation = false,
      this.iconSize,
      this.backgroundColor,
      this.animationDuration = const Duration(milliseconds: 270),
      this.navBarHeight = 0.0,
      @required this.items,
      this.onItemSelected,
      this.isCurved,
      this.isIOS = true});

  Widget _buildItem(
      PersistentBottomNavBarItem item, bool isSelected, double height) {
    return AnimatedContainer(
      width: isSelected ? 140 : 50,
      height: this.isIOS ? height / 2.3 : height / 1.6,
      duration: animationDuration,
      padding: EdgeInsets.all(item.contentPadding),
      decoration: BoxDecoration(
        color: isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Container(
        alignment: Alignment.center,
        height: this.isIOS ? height / 2.3 : height / 1.6,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconTheme(
                    data: IconThemeData(
                        size: iconSize,
                        color: isSelected
                            ? (item.activeContentColor == null ? item.activeColor : item.activeContentColor)
                            : item.inactiveColor == null
                                ? item.activeColor
                                : item.inactiveColor),
                    child: item.icon,
                  ),
                ),
                isSelected
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Material(
                          type: MaterialType.transparency,
                          child: FittedBox(
                              child: Text(
                            item.title,
                            style: TextStyle(
                                color: (item.activeContentColor == null ? item.activeColor : item.activeContentColor),
                                fontWeight: FontWeight.w400,
                                fontSize: item.titleFontSize),
                          )),
                        ),
                      )
                    : SizedBox.shrink()
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = (backgroundColor == null) ? Colors.white : backgroundColor;
    double _navBarHeight = 0.0;
    if (this.navBarHeight == 0.0) {
      if (this.isIOS) {
        _navBarHeight = 90.0;
      } else {
        _navBarHeight = 50.0;
      }
    } else {
      _navBarHeight = this.navBarHeight;
    }
    return Container(
      decoration: this.isCurved
          ? BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
              boxShadow: [
                if (showElevation)
                  BoxShadow(color: Colors.black12, blurRadius: 2)
              ],
            )
          : BoxDecoration(
              color: bgColor,
              boxShadow: [
                if (showElevation)
                  BoxShadow(color: Colors.black12, blurRadius: 2)
              ],
            ),
      child: Container(
        width: double.infinity,
        height: _navBarHeight,
        padding: this.isIOS
            ? EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.07,
                right: MediaQuery.of(context).size.width * 0.07,
                top: _navBarHeight * 0.12,
                bottom: _navBarHeight * 0.38,
              )
            : EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07,
                vertical: _navBarHeight * 0.15,
              ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment:
              this.isIOS ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: items.map((item) {
            var index = items.indexOf(item);
            return Flexible(
              flex: selectedIndex == index ? 2 : 1,
              child: GestureDetector(
                onTap: () {
                  this.onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index, _navBarHeight),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
