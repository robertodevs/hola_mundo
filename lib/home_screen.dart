import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/cover.png', width: double.infinity),
              const SizedBox(height: 10),
              const Text(
                'Promociones de la semana',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _buildProductCard(
                      index,
                      'assets/product1.png',
                      'Promocion ${index + 1}',
                      '230g',
                      'Promocion ${index + 1}',
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 175,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Stack(
                        children: [
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.shade200,
                                  Colors.grey.shade300,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16, top: 24),
                                  child: Text(
                                    'Prepared food',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10),
                              ),
                              child: Image.asset(
                                'assets/bottom.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(
    int index,
    String image,
    String name,
    String price,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/product1.png', width: 100, height: 100),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Promocion ${index + 1}',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const Icon(
                FontAwesomeIcons.star,
                color: Colors.green,
              ),
            ],
          ),
          Text(
            '230g',
            style: TextStyle(fontSize: 10),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              onPressed: () {},
              child: const Text(
                'Agregar',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: false,
      title: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.location_on),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'San Francisco',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                'California',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications),
        ),
      ],
    );
  }
}
