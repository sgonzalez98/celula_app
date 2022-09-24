import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/logoCefeg.png', width: 50, height: 50),
                const Text(
                  'Celula Cefeg',
                  style: TextStyle(color: Colors.white, fontSize: 26),
                ),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.red[500],
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text('Salir'),
                ),
              ],
            ),
          ),
        ),
        // title: const Text('Inicio'),

        // actions: [
        //   Padding(
        //       padding: const EdgeInsets.only(right: 10),
        //       child:
        //
        //   IconButton(onPressed: () {}, icon: const Icon(Icons.exit_to_app))
        // ],
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) => null,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined), label: 'Celulas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.meeting_room), label: 'Desarrollos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books_outlined), label: 'Informes'),
        ],
      ),
    );
  }
}
