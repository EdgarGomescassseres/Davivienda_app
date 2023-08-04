import 'package:app_davivienda/models/gasto.dart';
import 'package:flutter/material.dart';

class GastoDelArticulo extends StatelessWidget{
  const GastoDelArticulo({super.key, required this.gasto});

  final Gasto gasto;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(gasto.titulo, style: Theme.of(context).textTheme.titleLarge,),
           const SizedBox(height: 6),
            Row(
             children: [
              Text("\$${gasto.cantidad.toStringAsFixed(1)}"),
              const Spacer(),
                Row(
                children: [
                Icon(categoriaIconos[gasto.categoria]),
                 const SizedBox(width: 8),
                 Text(gasto.formatedDate)
                ],
              )
             ],
           )
          ],
        ),
      ),);
  }
}
