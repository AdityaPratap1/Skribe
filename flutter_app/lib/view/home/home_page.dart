import 'package:app/configuration/constraints.dart';
import 'package:app/configuration/size_config.dart';
import 'package:app/services/user_service.dart';
import 'package:app/view_models/navigation_model.dart';
import 'package:app/view_models/user.dart';
import 'package:app/view/home/calendar_page.dart';
import 'package:app/view/home/dashboard_page.dart';
import 'package:app/view/home/flashcards_page.dart';
import 'package:app/view/home/pomodoro_timer.dart';
import 'package:app/view/home/notebook_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  UserModel thisUser;
  HomePage({this.thisUser});
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _height;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    this._pageController = new PageController(
        initialPage: 2, viewportFraction: 1.0, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    this._height = SizeConfig.screenHeight;

    return ChangeNotifierProvider<NavigationModel>(
      create: (context) => NavigationModel(),
      child: Consumer<NavigationModel>(
        builder: (context, navigationModel, _) => Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              index: navigationModel.currentPage,
              items: <Widget>[
                Icon(Icons.check_circle,
                    size: this._height * .04, color: Colors.white),
                Icon(Icons.timer,
                    size: this._height * .04, color: Colors.white),
                Icon(Icons.dashboard,
                    size: this._height * .04, color: Colors.white),
                Icon(Icons.credit_card,
                    size: this._height * .04, color: Colors.white),
                Icon(
                  Icons.calendar_today,
                  size: _height * .04,
                  color: Colors.white,
                ),
              ],
              color: backGroundColor,
              height: _height * .06,
              buttonBackgroundColor: Colors.black,
              backgroundColor: primaryColor,
              animationCurve: Curves.easeInOut,
              onTap: (index) {
                navigationModel.currentPage = index;
                this._pageController.animateToPage(navigationModel.currentPage,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              },
            ),
            body: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: this._pageController,
                    onPageChanged: (page) {
                      navigationModel.currentPage = page;
                    },
                    children: [
                      NotebookPage(),
                      PomodoroTimer(),
                      Dashboard(),
                      FlashCardsPage(),
                      CalendarPage(),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
