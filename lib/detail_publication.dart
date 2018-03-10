import 'package:fluttersocial/Publication.dart';
import 'package:flutter/material.dart';

final double tamaniofoto = 256.0;

class clsDetailProduct extends StatelessWidget {
  clsDetailProduct(this.producto);

  final Publication producto;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new CustomScrollView(
      slivers: <Widget>[
        new SliverAppBar(
          backgroundColor: Colors.green,
          pinned: true,
          expandedHeight: 250.0,
          flexibleSpace: new FlexibleSpaceBar(
            title: const Text('Publication'),
            background: new Stack(
              fit: StackFit.expand,
              children: <Widget>[
                new Image.network(
                  producto.photo,
                  fit: BoxFit.cover,
                  height: tamaniofoto,
                ),
                const DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: const LinearGradient(
                      begin: const FractionalOffset(0.5, 0.0),
                      end: const FractionalOffset(0.5, 0.30),
                      colors: const <Color>[
                        const Color(0x60000000),
                        const Color(0x00000000)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        new SliverFixedExtentList(
          itemExtent: 50.0,
          delegate: new SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return new Container(
                alignment: FractionalOffset.center,
                color: Colors.lightGreen[100 * (index % 9)],
                child: new Text('list item $index'),
              );
            },
          ),
        ),
      ],
    ));
  }
}
