import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// recordar que esto es para formatear las fechas
final formateador = DateFormat.yMd();
// esto es para crear id aleatorios de tipo String
const uuid = Uuid();

// solo es un enum
enum Categoria { comida, viajes, ocio, trabajo }

const categoriaIconos = {
  Categoria.comida: Icons.lunch_dining,
  Categoria.viajes: Icons.flight_takeoff,
  Categoria.ocio: Icons.movie,
  Categoria.trabajo: Icons.work
};

// Esta clase es similar, a una entidad, basicamente se usa para hacer instancias
class Gasto {
  Gasto(
      {required this.titulo,
      required this.cantidad,
      required this.fecha,
      required this.categoria})
      : id = uuid.v4();

  final String id;
  final String titulo;
  final double cantidad;
  final DateTime fecha;
  final Categoria categoria;

  String get formatedDate {
    return formateador.format(fecha);
  }
}

class CuboGastos {
  const CuboGastos({required this.gastos, required this.categoria});

  CuboGastos.forCategory(List<Gasto> todosLosGastos, this.categoria)
      : gastos = todosLosGastos.where((gasto) => gasto.categoria == categoria).toList();

  final Categoria categoria;
  final List<Gasto> gastos;

  double get totalGastos {
    double suma = 0;

    for (final gasto in gastos) {
      suma = suma + gasto.cantidad;
    }

    return suma;
  }
}
