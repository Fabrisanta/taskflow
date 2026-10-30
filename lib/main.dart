
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

// Modelo de una tarea
class Task {
  final String title;
  final String description;
  final String priority;
  final String status;

  const Task({
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
  });
}

// Tarjeta reutilizable
class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onViewDetail;

  const TaskCard({
    super.key,
    required this.task,
    required this.onViewDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.assignment_outlined),
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Text(task.description),
            const SizedBox(height: 6),
            Text('Prioridad: ${task.priority}'),
            Text('Estado: ${task.status}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.visibility_outlined),
          tooltip: 'Ver detalle',
          onPressed: onViewDetail,
        ),
      ),
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

  final List<Task> tasks = const [
    Task(
      title: 'Estudiar Flutter',
      description: 'Repasar widgets y layouts.',
      priority: 'Alta',
      status: 'Pendiente',
    ),
    Task(
      title: 'Realizar tarea de programación',
      description: 'Completar los ejercicios de clase.',
      priority: 'Alta',
      status: 'Pendiente',
    ),
    Task(
      title: 'Leer documentación',
      description: 'Revisar la documentación de Dart.',
      priority: 'Media',
      status: 'Pendiente',
    ),
    Task(
      title: 'Organizar apuntes',
      description: 'Ordenar los apuntes de la semana.',
      priority: 'Baja',
      status: 'Completada',
    ),
    Task(
      title: 'Preparar exposición',
      description: 'Revisar los temas para presentar.',
      priority: 'Media',
      status: 'Pendiente',
    ),
  ];

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

  void showTaskDetail(Task task) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(task.title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.description),
              const SizedBox(height: 12),
              Text('Prioridad: ${task.priority}'),
              Text('Estado: ${task.status}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaskFlow'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¡Hola, $studentName!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('Bienvenido/a a $courseName.'),
            const SizedBox(height: 8),
            const Text(
              '¡Organiza tus tareas y alcanza tus metas!',
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.pending_actions),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Tareas pendientes: $pendingTasks',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: addTask,
                    icon: const Icon(Icons.add),
                    label: const Text('Agregar tarea'),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: ElevatedButton.icon(
                    onPressed:
                        pendingTasks > 0 ? completeTask : null,
                    icon: const Icon(Icons.check),
                    label: const Text('Completar'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Mis tareas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];

                  return TaskCard(
                    task: task,
                    onViewDetail: () => showTaskDetail(task),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
