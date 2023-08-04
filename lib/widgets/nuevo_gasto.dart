import 'package:flutter/material.dart';
import 'package:app_davivienda/models/gasto.dart';

class NuevoGasto extends StatefulWidget {
  const NuevoGasto({super.key, required this.anadirGasto});

  final void Function(Gasto gasto) anadirGasto; 

  @override
  State<NuevoGasto> createState() {
    return _NuevoGastoState();
  }
}

class _NuevoGastoState extends State<NuevoGasto> {
  final _tituloController = TextEditingController();
  final _montoController = TextEditingController();
  DateTime? _fechaseleted;
  Categoria _seleccionarCategoria = Categoria.ocio;

  void _selectorFecha() async {
    final now = DateTime.now();
    final primeraFecha = DateTime(now.year - 1, now.month, now.day);

    //Esto se nos brinda un calendario
    final fechaSeleccionada = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: primeraFecha,
        lastDate: now);

    setState(() {
      _fechaseleted = fechaSeleccionada;
    });
  }

  void _enviarDatos() {

    final cantidadIntroducida = double.tryParse(_montoController.text);
    final cantidadNoValida =
        cantidadIntroducida == null || cantidadIntroducida <= 0;
    Gasto gasto;

    if (_tituloController.text.trim().isEmpty ||
        cantidadNoValida ||
        _fechaseleted == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Dato invalido"),
              content: const Text(
                "Por favor verifique que todos los datos, hayan sido ingresado correctamente",
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("Volver")),
              ],
            );
          });
      return;
    }

    gasto = Gasto(
        titulo: _tituloController.text,
        cantidad: cantidadIntroducida,
        fecha: _fechaseleted!,
        categoria: _seleccionarCategoria);

    widget.anadirGasto(gasto);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _montoController.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    final espacioTeclado = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, limitaciones) {
      final ancho = limitaciones.maxWidth;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          // padding se hace cargo de agregar espacio vacío al rededor de un widget o múltiples de estos
          padding: EdgeInsets.fromLTRB(20,48,20,espacioTeclado + 20),
          child: Column(
            children: [
              if(ancho >= 600)
                Row(children: [
                  Expanded(
                    child: TextField(
                                  //Simplemente capturo el texto que agregan en la casilla
                                  controller: _tituloController,
                                  maxLength: 50,
                                  decoration: const InputDecoration(
                    label: Text("titulo"),
                                  ),
                                ),
                  ),
              const SizedBox(height: 24,)
                ],)
              else
                TextField(
                //Simplemente capturo el texto que agregan en la casilla
                controller: _tituloController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("titulo"),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _montoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          label: Text("Monto"), prefixText: "\$ "),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_fechaseleted == null
                            ? "fecha"
                            : formateador.format(_fechaseleted!)),
                        IconButton(
                            onPressed: _selectorFecha,
                            icon: const Icon(Icons.date_range_outlined))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  //esto se utiliza para tener una lista desplegable
                  DropdownButton(
                      value: _seleccionarCategoria,
                      items: Categoria.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          _seleccionarCategoria = value;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancelar")),
                  ElevatedButton(
                      onPressed: _enviarDatos, child: const Text("Guardar"))
                ],
              )
            ],
          ),
        ),
      ),
    );
    });
    
  }
}
