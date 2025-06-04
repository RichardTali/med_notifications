import 'package:flutter/material.dart';
import 'package:med_notifications/screens/form_medicamento.dart';

class MedicamentoScreen extends StatefulWidget {
  const MedicamentoScreen({super.key});

  @override
  State<MedicamentoScreen> createState() => _MedicamentoScreenState();
}

class _MedicamentoScreenState extends State<MedicamentoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SizedBox(
        height: 680,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 30),
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
            // Aquí podrías agregar una lista o más contenido
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return const formularioMedicamento(); // Asegúrate de tener este widget
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
