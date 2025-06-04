import 'package:flutter/material.dart';

class formularioMedicamento extends StatefulWidget {
  const formularioMedicamento({super.key});

  @override
  State<formularioMedicamento> createState() => _formularioMedicamentoState();
}

class _formularioMedicamentoState extends State<formularioMedicamento> {
  String? _selectedValue;
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;

  void _updateDateTime(DateTime date, TimeOfDay time) {
    setState(() {
      _selectedDate = date;
      _selectedTime = time;
    });
  }

  void _sheduleNotification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Simulación: Programado para ${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year} a las ${_selectedTime?.format(context)}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: SizedBox(
        height: 800,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 48,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Registrar Medicamento',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Nombre del medicamento',
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.teal),
            ),
            const TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration.collapsed(
                hintText: 'Ingrese el nombre del medicamento',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Dosis',
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.teal),
            ),
            DropdownButton<String>(
              value: _selectedValue,
              hint: const Text("Seleccione una opción"),
              items:
                  [
                    'Tableta',
                    'Capsula',
                    'Unidad',
                    'Pastillas',
                    'Mililitros',
                    'Miligramos',
                    'Inyección',
                    'Gotas',
                    'Cucharada',
                    'Cucharaditas',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Cantidad',
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.teal),
            ),
            const TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration.collapsed(
                hintText: 'Fecha de inicio',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 16),
            DateTimeSelector(
              selectedDate: _selectedDate,
              selectedTime: _selectedTime,
              onDateTimeChanged: _updateDateTime,
            ),
            const SizedBox(height: 16),

            const SizedBox(height: 20),
            Text(
              'Inicio del tratamiento',
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.teal),
            ),
            const TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration.collapsed(
                hintText: '20/10/2023',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 20),
            Text(
              'Fin del tratamiento',
              style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.teal),
            ),
            const TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration.collapsed(
                hintText: '20/10/2023',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),

  const SizedBox(height: 20),
            SizedBox(
              height: 35,
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  // Aquí puedes poner tu lógica
                  print("Medicamento agregado");
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                child: const Text('Add', style: TextStyle(color: Colors.white)),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // HORA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Horario de toma", style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.teal),),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: const Text("Seleccionar hora"),
                ),
                if (selectedTime != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(selectedTime!.format(context)),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16), 
          // FECHA
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Fecha de toma", style: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.teal), ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text("Seleccionar fecha"),
                ),
                if (selectedDate != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
