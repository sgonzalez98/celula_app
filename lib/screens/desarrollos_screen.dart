import 'package:flutter/material.dart';

class DesarrollosScreen extends StatelessWidget {
  const DesarrollosScreen({Key? key}) : super(key: key);

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
                  'Desarrollos',
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
      ),
      body: Container(),
    );
  }
}
