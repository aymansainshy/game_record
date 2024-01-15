import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hareeg/src/features/games/views/widgets/create_new_game_bottom_sheet.dart';
import 'package:hareeg/src/features/games/views/current_game_list_view.dart';
import 'package:hareeg/src/features/games/views/history_game_list_view.dart';
import 'package:hareeg/src/features/home/widgets/custom_buttom_nav_bar.dart';
import 'package:hareeg/src/utils/assets_helper.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // final GlobalKey _popupMenuKey = GlobalKey();
  var pageIndex = 0;

  final bottomNavItems = [
    BottomNavItem(CupertinoIcons.play_arrow_solid, "Current Game"),
    BottomNavItem(CupertinoIcons.square_favorites_alt, "History"),
  ];

  final List<Widget> _views = const [
    CurrentGameView(),
    HistoryGameView(),
  ];

  void showPopupMenu(BuildContext context) {
    // final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    // final RenderBox button = _popupMenuKey.currentContext!.findRenderObject() as RenderBox;
    // final Offset position = button.localToGlobal(Offset.zero, ancestor: overlay);

    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(100, 0, 0, 0),
      //RelativeRect.fromLTRB(position.dx, position.dy, position.dx, position.dy),
      items: [
        const PopupMenuItem(
          value: '',
          child: Text(''),
        ),
        PopupMenuItem(
          value: 'Logout',
          onTap: () {
            // BlocProvider.of<LogOutCubit>(context).logOut();
          },
          child: Row(
            children: [
              const Text('Logout'),
              const SizedBox(width: 5),
              Icon(Icons.logout, color: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ],
    );
  }

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);

    return Scaffold(
      floatingActionButton: pageIndex == 0
          ? FloatingActionButton.extended(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const CreateNewGameBottomSheet();
                  },
                );
              },
              icon: const Icon(Icons.games_outlined),
              label: const Text("Start New Game"),
            )
          : null,
      bottomNavigationBar: CBottomNavigationBar(
        bottomNavItems: bottomNavItems,
        pageIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: SizedBox(
          height: mediaQuery.height,
          width: mediaQuery.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: mediaQuery.width * 0.75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back,  Guys",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Have your fun playing the game ♠️♥️♣️♦️ ",
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // showPopupMenu(context);
                        },
                        child: Image.asset(
                          AssetsUtils.recordImage,
                          height: 60,
                          width: 60,
                        ),
                        // CircleAvatar(
                        //   radius: 25,
                        //   backgroundColor: Theme.of(context).colorScheme.secondary,
                        //   child: const Icon(
                        //     CupertinoIcons.person,
                        //     size: 30,
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.03),
              Expanded(child: _views[pageIndex]),
            ],
          ),
        ),
      ),
    );
  }
}
