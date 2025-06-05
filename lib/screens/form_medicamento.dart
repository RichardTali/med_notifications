import 'package:flutter/material.dart';
import 'package:med_notifications/db/db_helper.dart';
import 'package:med_notifications/models/medicamento.dart';
import 'package:med_notifications/screens/medicamento_screen.dart';


class FormularioMedicamento extends StatefulWidget {
  const FormularioMedicamento({super.key});

  @override
  State<FormularioMedicamento> createState() => _FormularioMedicamentoState();
}

class _FormularioMedicamentoState extends State<FormularioMedicamento> {
  String? _selectedValue;
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final TextEditingController _inicioController = TextEditingController();
  final TextEditingController _finController = TextEditingController();

  void _updateDateTime(DateTime date, TimeOfDay time) {
    setState(() {
      _selectedDate = date;
      _selectedTime = time;
    });
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _cantidadController.dispose();
    _inicioController.dispose();
    _finController.dispose();
    super.dispose();
  }

  Future<void> _guardarMedicamento() async {
    final medicamento = Medicamento(
      nombre: _nombreController.text,
      dosis: _selectedValue ?? 'Sin dosis',
      cantidad: _cantidadController.text,
      inicio: _inicioController.text,
      fin: _finController.text,
      fechaToma: _selectedDate != null
          ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
          : 'No definida',
      horaToma: _selectedTime != null ? _selectedTime!.format(context) : 'No definida',
    );

    await DBHelper.insertMedicamento(medicamento);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Medicamento guardado Correctamente')),
    );

    Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => MedicamentoScreen()),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Medicamento')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: 'Nombre del medicamento',
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedValue,
              decoration: const InputDecoration(labelText: 'Dosis'),
              hint: const Text("Seleccione una opción"),
              items: [
                'Tableta', 'Capsula', 'Unidad', 'Pastillas', 'Mililitros',
                'Miligramos', 'Inyección', 'Gotas', 'Cucharada', 'Cucharaditas',
              ].map((String value) {
                return DropdownMenuItem<String>(value: value, child: Text(value));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _cantidadController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Cantidad'),
            ),
            const SizedBox(height: 20),
            DateTimeSelector(
              selectedDate: _selectedDate,
              selectedTime: _selectedTime,
              onDateTimeChanged: _updateDateTime,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _inicioController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(labelText: 'Inicio del tratamiento'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _finController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(labelText: 'Fin del tratamiento'),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 45,
              width: 250,
              child: ElevatedButton(
                onPressed: _guardarMedicamento,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text('Guardar', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// WIDGET PERSONALIZADO PARA FECHA Y HORA
class DateTimeSelector extends StatelessWidget {
  final DateTime? selectedDate;
  final TimeOfDay? selectedTime;
  final Function(DateTime, TimeOfDay) onDateTimeChanged;

  const DateTimeSelector({
    Key? key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateTimeChanged,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      onDateTimeChanged(picked, selectedTime ?? TimeOfDay.now());
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      onDateTimeChanged(selectedDate ?? DateTime.now(), picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Fecha y hora de toma"),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _selectDate(context),
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : 'Seleccionar fecha',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _selectTime(context),
                icon: const Icon(Icons.access_time),
                label: Text(
                  selectedTime != null
                      ? selectedTime!.format(context)
                      : 'Seleccionar hora',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
