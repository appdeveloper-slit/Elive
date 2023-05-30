import 'package:elive/homepage/mainhomepage.dart';
import 'package:elive/homepage/profile.dart';
import 'package:elive/homepage/servicespage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({Key? key}) : super(key: key);

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(inactiveColor: const Color(0xffffc107),activeColor: const Color(0xffffc107),backgroundColor: const Color(0xff333741),items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/home.svg',height: 21), label: 'Home',),
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(
              // ignore: prefer_const_constructors
              icon: SvgPicture.asset('assets/images/settings.svg',height: 21),
              label: 'Services'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/images/myprofile.svg'),
              label: 'Profile'),
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: (context) {
                  return const CupertinoPageScaffold(
                    child: MainHomePage(),
                  );
                },
              );
            case 1:
              return CupertinoTabView(
                builder: (context) {
                  return const CupertinoPageScaffold(
                    child: Servicespage(),
                  );
                },
              );
            case 2:
              return CupertinoTabView(
                builder: (context) {
                  return const CupertinoPageScaffold(
                    child: Profilepage(),
                  );
                },
              );
            default: return CupertinoTabView(
                builder: (context) {
                  return const CupertinoPageScaffold(
                    child: MainHomePage(),
                  );
                },
              );
          }
        });
  }
}
