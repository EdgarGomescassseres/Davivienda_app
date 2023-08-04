import 'package:app_davivienda/widgets/chart/chart.dart';
import 'package:app_davivienda/widgets/lista_gastos/gastos_lista.dart';
import 'package:app_davivienda/widgets/nuevo_gasto.dart';
import 'package:flutter/material.dart';
import 'package:app_davivienda/models/gasto.dart';

class Gastos extends StatefulWidget {
  const Gastos({super.key});

  @override
  State<Gastos> createState() {
    return _GastosState();
  }
}

class _GastosState extends State<Gastos> {
  final List<Gasto> _registrarGasto = [
    Gasto(
        titulo: "Curso Flutter",
        cantidad: 23230,
        fecha: DateTime.now(),
        categoria: Categoria.trabajo),
    Gasto(
        titulo: "cine",
        cantidad: 34250,
        fecha: DateTime.now(),
        categoria: Categoria.ocio),
    Gasto(
        titulo: "Mackg's Big",
        cantidad: 57900,
        fecha: DateTime.now(),
        categoria: Categoria.comida)
  ];

  void addGasto(Gasto gasto) {
    setState(() {
      _registrarGasto.add(gasto);
    });
  }

  void _abrirSuperposicionDatos() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NuevoGasto(anadirGasto: addGasto));
  }

  void _eliminarGasto(Gasto gasto) {
    final GastoIndice = _registrarGasto.indexOf(gasto);
    setState(() {
      _registrarGasto.remove(gasto);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration:const Duration(seconds: 3),
        content: const Text("Se ha eliminado con exito"),
        action: SnackBarAction(label: 'Desahacer', onPressed: () {
          setState(() {
            _registrarGasto.insert(GastoIndice, gasto);
          });
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final anchura = MediaQuery.of(context).size.width;
 

    Widget mainContent =
        const Center(child: Text("No se ha registrado ningun Gasto"));

    if (_registrarGasto.isNotEmpty) {
      mainContent =
          ListaDeGastos(gastos: _registrarGasto, remover: _eliminarGasto);
    }

    return Scaffold(
      //appBar se utiliza, para agregar una barra en la parte de arriba de la App
      appBar: AppBar(
        title: const Text("MonoVienda"),
        actions: [
          IconButton(
            onPressed: _abrirSuperposicionDatos,
            icon: const Icon(Icons.add_outlined),
          ),
        ],
      ),
      // en el body se llama la lista de gastos que se mostraran en pantalla
      body: anchura < 600 ? Column(
        children: [ 
          Chart(expenses: _registrarGasto), 
        Expanded(child: mainContent)],
      ): Row(
        children: [
          Expanded(child:Chart(expenses: _registrarGasto)), 
        Expanded(child: mainContent)
        ],
      ),
    );
  }
}
