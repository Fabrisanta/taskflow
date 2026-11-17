import 'package:flutter_test/flutter_test.dart';

import 'package:taskflow/main.dart';

void main() {
  testWidgets('TaskFlow carga correctamente la lista de tareas', (WidgetTester tester) async {
    // Construimos nuestra app y disparamos un frame.
    await tester.pumpWidget(const TaskFlowApp());

    // Verificamos que al menos aparezca el título de la AppBar o una tarea.
    expect(find.text('Mis tareas - TaskFlow'), findsOneWidget);
  });
}