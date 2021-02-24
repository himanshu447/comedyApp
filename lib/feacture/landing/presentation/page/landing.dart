import 'package:comedy/feacture/landing/presentation/bloc/landing_bloc.dart';
import 'package:comedy/injector.dart';
import 'package:comedy/utils/component/bottom_nav_component.dart';
import 'package:comedy/utils/component/text_component.dart';
import 'package:comedy/utils/enum_util.dart';
import 'package:comedy/utils/string_util.dart';
import 'package:comedy/utils/style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingView extends StatefulWidget {
  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  LandingBloc landingBloc;

  void _onItemTapped(int index) {
    landingBloc.add(BottomTabChangeEvent(landingTab: LandingTab.values[index]));
  }

  @override
  void initState() {
    super.initState();
    landingBloc = injector<LandingBloc>();
  }

  @override
  void dispose() {
    landingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingBloc, LandingState>(
      cubit: landingBloc,
      builder: (_, state) {
        if (state is LandingInitialState) {
          landingBloc.add(BottomTabChangeEvent(landingTab: LandingTab.home));
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LoadedState) {
          return loadBody(state.selectedTab);
        } else {
          return Container(
            color: Colors.red,
          );
        }
      },
    );
  }

  Widget loadBody(LandingTab selectedTab) {
    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: [
          Center(
            child: TextComponent(
              title: 'TAB 1',
            ),
          ),
          Center(
            child: TextComponent(
              title: 'TAB 2',
            ),
          ),
          Center(
            child: TextComponent(
              title: 'TAB 3',
            ),
          ),
          Center(
            child: TextComponent(
              title: 'TAB 4',
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        onTap: _onItemTapped,
        labelStyle: LabelStyle(
          onSelectTextStyle: StyleUtil.bottomTabTextStyle,
          textStyle: StyleUtil.bottomTabTextStyle,
        ),
        items: <BottomNavItem>[
          BottomNavItem(
            label: AppString.home,
            imageProvider: AssetImage(
              selectedTab != LandingTab.home
                  ? 'assets/images/icons/bottom_bar/nav_home.png'
                  : 'assets/images/icons/bottom_bar/nav_home_active.png',
            ),
          ),
          BottomNavItem(
            label: AppString.my_saved,
            imageProvider: AssetImage(
              selectedTab != LandingTab.mySaved
                  ? 'assets/images/icons/bottom_bar/nav_save.png'
                  : 'assets/images/icons/bottom_bar/nav_save_active.png',
            ),
          ),
          BottomNavItem(
            label: AppString.submit_prompt,
            imageProvider: AssetImage(
              selectedTab != LandingTab.submitPrompt
                  ? 'assets/images/icons/bottom_bar/nav_prompt.png'
                  : 'assets/images/icons/bottom_bar/nav_prompt_active.png',
            ),
          ),
          BottomNavItem(
            label: AppString.about,
            imageProvider: AssetImage(
              selectedTab != LandingTab.about
                  ? 'assets/images/icons/bottom_bar/nav_about.png'
                  : 'assets/images/icons/bottom_bar/nav_about_active.png',
            ),
          ),
        ],
      ),
    );
  }
}

/*
BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/icons/bottom_bar/nav_home.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'assets/images/icons/bottom_bar/nav_home_active.png',
              height: 20,
              width: 20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppString.my_saved,
            icon: Image.asset(
              'assets/images/icons/bottom_bar/nav_save.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'assets/images/icons/bottom_bar/nav_save_active.png',
              height: 20,
              width: 20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppString.submit_prompt,
            icon: Image.asset(
              'assets/images/icons/bottom_bar/nav_prompt.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'assets/images/icons/bottom_bar/nav_prompt_active.png',
              height: 20,
              width: 20,
            ),
          ),
          BottomNavigationBarItem(
            label: AppString.about,
            icon: Image.asset(
              'assets/images/icons/bottom_bar/nav_about.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Image.asset(
              'assets/images/icons/bottom_bar/nav_about_active.png',
              height: 20,
              width: 20,
            ),
          ),
 */
