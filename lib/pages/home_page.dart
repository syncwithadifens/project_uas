import 'package:flutter/material.dart';
import 'package:project_uas/model/food_model.dart';
import 'package:project_uas/services/http_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpService httpService = HttpService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Find the food you like here!',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 0, bottom: 10, left: 24, right: 24),
            child: Text(
              'Populer',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: FutureBuilder<List<FoodModel>>(
                      future: httpService.getData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return ListView(
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Container(
                                      height: 200,
                                      width: 140,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          image: NetworkImage(e.picturePath),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: double.infinity,
                                        height: 30,
                                        color: Colors.deepPurple[400],
                                        child: Center(
                                          child: Text(
                                            e.name,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 24, right: 24, top: 30),
            child: Text(
              'Menu',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<FoodModel>>(
              future: httpService.getData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    children: snapshot.data
                        .map((e) => Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                              child: ListTile(
                                leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      e.picturePath,
                                      width: 80,
                                    )),
                                title: Text(e.name),
                                subtitle: Text(e.ingredients),
                                trailing: Text('Rp ${e.price.toString()}'),
                              ),
                            ))
                        .toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: const Color(0xff272C2F),
        currentIndex: 0,
        items: [
          const BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/nav1.png'),
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/nav2.png'),
              ),
              label: 'Notifications'),
          const BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/nav4.png'),
              ),
              label: 'Profile'),
          BottomNavigationBarItem(
              icon: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.exit_to_app_rounded)),
              label: 'Keluar'),
        ],
      ),
    );
  }
}
