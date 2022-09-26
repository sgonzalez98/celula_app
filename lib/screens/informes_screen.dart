import 'package:flutter/material.dart';

class InformesScreen extends StatelessWidget {
  const InformesScreen({Key? key}) : super(key: key);

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
                  'Informes',
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
