import 'package:flutter/material.dart';

class CelulasScreen extends StatelessWidget {
  const CelulasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/logoCefeg.png', width: 50, height: 50),
                const Text(
                  'Celulas',
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
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(children: [
          MaterialButton(
            onPressed: () {},
            color: Colors.green,
            textColor: Colors.white,
            child: const Text('Agregar Nueva Celula'),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) => Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue[800]),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Celula',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text('Ministerio: Jovenes',
                          style: TextStyle(color: Colors.white)),
                      Text('Encargado: Camila Davila',
                          style: TextStyle(color: Colors.white)),
                      Text('Lugar: Vereda la chapa',
                          style: TextStyle(color: Colors.white)),
                      Text('Dia: Lunes', style: TextStyle(color: Colors.white)),
                      Text('Hora: 08:00 PM',
                          style: TextStyle(color: Colors.white)),
                      Text('Descripcion: Celula del ministerio de jovenes',
                          style: TextStyle(color: Colors.white))
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
