import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hola_mundo/common/blocs/home_bloc.dart';
import 'package:hola_mundo/common/pages/home_screen.dart';
import 'package:hola_mundo/custom_router.dart';
import 'package:hola_mundo/injector.dart';
import 'package:hola_mundo/profile_management/pages/profile_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentIndex = 0;

  final homeBloc = HomeBloc();
  final List<Widget> _pages = [
    const HomeScreen(),
    const Scaffold(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Injector.register<HomeBloc>(homeBloc);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final isMobile = constraints.maxWidth < 600;
      final isTablet =
          constraints.maxWidth >= 600 && constraints.maxWidth <= 900;

      if (isMobile) {
        return _buildMobileView(context);
      } else if (isTablet) {
        return _buildTabletView(context);
      } else {
        return _buildDesktopView(context);
      }
    });
  }

  Widget _buildTabletView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hola Mundo Tablet'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              CustomRouter.of(context).push('/notifications');
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Text(
                'Hola Mundo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: Text('home.title'.tr()),
              selected: currentIndex == 0,
              onTap: () {
                setState(() => currentIndex = 0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: Text('search.title'.tr()),
              selected: currentIndex == 1,
              onTap: () {
                setState(() => currentIndex = 1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text('profile.title'.tr()),
              selected: currentIndex == 2,
              onTap: () {
                setState(() => currentIndex = 2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CustomRouter.of(context).push('/add-product');
        },
        child: const Icon(Icons.add),
      ),
      body: _pages[currentIndex],
    );
  }

  Widget _buildDesktopView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hola Mundo'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              CustomRouter.of(context).push('/notifications');
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            destinations: [
              NavigationRailDestination(
                icon: const Icon(Icons.home),
                label: Text('home.title'.tr()),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.search),
                label: Text('search.title'.tr()),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.person),
                label: Text('profile.title'.tr()),
              ),
            ],
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              setState(() => currentIndex = index);
            },
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Stack(
              children: [
                _pages[currentIndex],
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: () {
                      CustomRouter.of(context).push('/add-product');
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hola Mundo'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              CustomRouter.of(context).push('/notifications');
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CustomRouter.of(context).push('/add-product');
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _pages[currentIndex],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'home.title'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'search.title'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'profile.title'.tr(),
        ),
      ],
    );
  }
}
