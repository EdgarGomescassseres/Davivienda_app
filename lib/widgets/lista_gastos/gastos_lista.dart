import 'package:app_davivienda/models/gasto.dart';
import 'package:app_davivienda/widgets/lista_gastos/articulo_gasto.dart';
import 'package:flutter/material.dart';

//En esta clase realice mi recuento de articulos atravez de una funcion nueva
// es itemBuilder al parecer recive por parametro un contexto y un indice
// luego a GastoDelArticulo, le paso mi lista de objeto de gastos
class ListaDeGastos extends StatelessWidget {
  const ListaDeGastos({super.key, required this.gastos, required this.remover});

  final List<Gasto> gastos;
  final void Function(Gasto gasto) remover;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gastos.length,
      itemBuilder: (ctx, index) => Dismissible(
          background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(1),
          margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),),
          key: ValueKey(gastos[index]),
          onDismissed: (dr) {remover(gastos[index]);},
          child: GastoDelArticulo(gasto: gastos[index])),
    );
  }
}
