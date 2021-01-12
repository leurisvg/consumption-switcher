import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const _switcherHeight = 65.0;
const _switcherWidth = 135.0;
const _switcherBaseHeight = 50.0;
const _iconPadding = 23.0;
const _iconSize = 30.0;

const _darkBlue = Color(0xff3c86b7);
const _lightBlue = Color(0xff08c2c9);
const _iconBlue = Color(0xff8bc7e4);

const _darkYellow = Color(0xffdb8306);
const _lightYellow = Color(0xffffc900);
const _iconYellow = Color(0xffffb41c);

const _duration = const Duration(milliseconds: 300);

class ConsumptionSwitcher extends StatelessWidget {
  final ValueChanged<bool> onChanged;

  ConsumptionSwitcher({@required this.onChanged});

  final ValueNotifier<List> _notifierList = ValueNotifier<List>([false, true]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consumption Switcher'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            _notifierList.value[0] = !_notifierList.value[0];
            _notifierList.value[1] = false;
            _notifierList.notifyListeners();

            onChanged(_notifierList.value[0]);
          },
          child: SizedBox(
            height: _switcherHeight,
            width: _switcherWidth,
            child: ValueListenableBuilder<List>(
              valueListenable: _notifierList,
              builder: (BuildContext context, value, _) {
                final _iconTopPosition = (_switcherHeight / 2) - (_iconSize / 2) - 2;

                return Stack(
                  children: [
                    Positioned(
                      top: (_switcherHeight / 2) - (_switcherBaseHeight / 2),
                      child: AnimatedContainer(
                        duration: _duration,
                        height: _switcherBaseHeight,
                        width: _switcherWidth,
                        decoration: BoxDecoration(
                          color: value[0] ? _darkYellow : _darkBlue,
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(40.0), right: Radius.circular(40.0)),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: _duration,
                      curve: Curves.easeOutCubic,
                      left: value[0] ? _switcherWidth - _switcherHeight : 0,
                      child: AnimatedContainer(
                        duration: _duration,
                        height: _switcherHeight,
                        width: _switcherHeight,
                        decoration: BoxDecoration(
                          color: value[0] ? _lightYellow : _lightBlue,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26.withOpacity(0.2),
                              offset: Offset(0.0, 4.0),
                              blurRadius: 2.5,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: _iconTopPosition,
                      left: _iconPadding,
                      child: TweenAnimationBuilder(
                        duration: _duration,
                        tween: value[0] ? ColorTween(begin: Colors.white, end: _iconYellow) : ColorTween(begin: _iconYellow, end: Colors.white),
                        builder: (BuildContext context, color, _) {
                          return FaIcon(
                            FontAwesomeIcons.dollarSign,
                            size: _iconSize,
                            color: value[1] ? Colors.white : color,
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: _iconTopPosition,
                      right: _iconPadding,
                      child: TweenAnimationBuilder(
                        duration: _duration,
                        tween: !value[0] ? ColorTween(begin: Colors.white, end: _iconBlue) : ColorTween(begin: _iconBlue, end: Colors.white),
                        builder: (BuildContext context, color, _) {
                          return FaIcon(
                            FontAwesomeIcons.bolt,
                            size: _iconSize,
                            color: value[1] ? _iconBlue : color,
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
