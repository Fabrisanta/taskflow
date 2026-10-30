
import 'package:flutter/material.dart';

void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final String studentName = 'Fabricio';
  final String courseName = 'Desarrollo de aplicaciones móviles';

  int pendingTasks = 3;

  void addTask() {
    setState(() {
      pendingTasks++;
    });
  }

  void completeTask() {
    if (pendingTasks == 0) return;

    setState(() {
      pendingTasks--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskFlow'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.task_alt,
                size: 64,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '¡Hola, $studentName!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text('Bienvenido/a a $courseName.'),
            const SizedBox(height: 16),
            const Text(
              '¡Organiza tus tareas y alcanza tus metas!',
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.pending_actions,
                    size: 40,
                    color: Colors.indigo,
                  ),
                  const SizedBox(height: 12),
                  const Text('Tareas pendientes'),
                  const SizedBox(height: 8),
                  Text(
                    '$pendingTasks',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                onPressed: addTask,
                icon: const Icon(Icons.add),
                label: const Text('Agregar tarea'),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton.icon(
                onPressed: pendingTasks > 0 ? completeTask : null,
                icon: const Icon(Icons.check),
                label: const Text('Completar tarea'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
