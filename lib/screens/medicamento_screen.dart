import 'package:flutter/material.dart';
import 'package:med_notifications/screens/form_medicamento.dart';
import 'package:med_notifications/models/medicamento.dart';
import 'package:med_notifications/db/db_helper.dart';

class MedicamentoScreen extends StatefulWidget {
  const MedicamentoScreen({super.key});

  @override
  State<MedicamentoScreen> createState() => _MedicamentoScreenState();
}

class _MedicamentoScreenState extends State<MedicamentoScreen> {
  List<Medicamento> _listaMedicamentos = [];

  @override
  void initState() {
    super.initState();
    _cargarMedicamentos();
  }

  Future<void> _cargarMedicamentos() async {
    final datos = await DBHelper.getMedicamentos();
    setState(() {
      _listaMedicamentos = datos;
    });
  }

  void _abrirFormulario() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const FormularioMedicamento(),
    ).then((_) {
      // Recarga la lista al cerrar el formulario
      _cargarMedicamentos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Medicamentos',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: _listaMedicamentos.isEmpty
                  ? const Center(child: Text('No hay medicamentos registrados'))
                  : ListView.builder(
                      itemCount: _listaMedicamentos.length,
                      itemBuilder: (context, index) {
                        final med = _listaMedicamentos[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: ListTile(
                            title: Text(med.nombre),
                            subtitle: Text(
                              'Dosis: ${med.dosis} - Cantidad: ${med.cantidad}\n'
                              'Inicio: ${med.inicio} / Fin: ${med.fin}\n'
                              'Toma: ${med.fechaToma} a las ${med.horaToma}',
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: _abrirFormulario,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
