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
