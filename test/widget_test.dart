import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/app/taskflow_app.dart';

void main() {
  testWidgets('TaskFlow carga correctamente la lista de tareas', (WidgetTester tester) async {
    // Construimos nuestra app y disparamos un frame.
    await tester.pumpWidget(const TaskFlowApp());

    // Verificamos que aparezca el título de la AppBar.
    expect(find.text('Mis tareas'), findsOneWidget);
  });
}