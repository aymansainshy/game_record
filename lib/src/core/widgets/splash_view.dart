import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hareeg/src/core/on-app-started-bloc/on_app_started_bloc.dart';
import 'package:hareeg/src/theme/app_theme.dart';

late int _duration;
late String _imagePath;

class AnimatedSplashView extends StatefulWidget {
  AnimatedSplashView({
    Key? key,
    required int duration,
    required String imagePath,
  }) : super(key: key) {
    _duration = duration;
    _imagePath = imagePath;
  }

  @override
  AnimatedSplashState createState() => AnimatedSplashState();
}

class AnimatedSplashState extends State<AnimatedSplashView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    if (_duration < 800) _duration = 800;

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _duration),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInCirc,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: FadeTransition(
          opacity: _animation,
          child: BlocListener<OnAppStartedAppBloc, OnAppStartedAppState>(
            listener: (context, appState) {
              if (appState is AppSetupInFailure) {
                // if (kDebugMode) {
                //   print(appState.error.toString());
                // }
                // simpleErrorDialog(context, () {
                //   BlocProvider.of<OnAppStartedAppBloc>(context).add(AppStarted());
                // });
              }
            },
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const SizedBox(height: 40),
                  Transform.translate(
                    offset: const Offset(0, 30),
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      height: mediaQuery.height / 3.5,
                      width: mediaQuery.width,
                      child: Image.asset(_imagePath),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // SizedBox(
                  //   height: isLandScape ? ScreenUtil().setHeight(800) : ScreenUtil().setHeight(200),
                  //   width: isLandScape ? ScreenUtil().setWidth(700) : ScreenUtil().setWidth(800),
                  //   child: const SpinKitThreeBounce(
                  //     color: AppColors.borderColor,
                  //     size: 19,
                  //     duration: Duration(milliseconds: 800),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
