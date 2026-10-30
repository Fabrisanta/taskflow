
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const TaskFlowApp());
}

// Modelo de tarea
class Task {
  final int id;
  final String title;
  final String description;
  final String priority;
  final String status;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
  });
}

// Cinco tareas de prueba
const List<Task> tasks = [
  Task(
    id: 1,
    title: 'Estudiar Flutter',
    description: 'Repasar widgets y layouts.',
    priority: 'Alta',
    status: 'Pendiente',
  ),
  Task(
    id: 2,
    title: 'Realizar tarea de programación',
    description: 'Completar los ejercicios de clase.',
    priority: 'Alta',
    status: 'Pendiente',
  ),
  Task(
    id: 3,
    title: 'Leer documentación',
    description: 'Revisar la documentación de Dart.',
    priority: 'Media',
    status: 'Pendiente',
  ),
  Task(
    id: 4,
    title: 'Organizar apuntes',
    description: 'Ordenar los apuntes de la semana.',
    priority: 'Baja',
    status: 'Completada',
  ),
  Task(
    id: 5,
    title: 'Preparar exposición',
    description: 'Revisar los temas para presentar.',
    priority: 'Media',
    status: 'Pendiente',
  ),
];

// Configuración de rutas
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
      routes: [
        GoRoute(
          path: 'task/:id',
          builder: (context, state) {
            final id = int.tryParse(
              state.pathParameters['id'] ?? '',
            );

            Task? selectedTask;

            for (final task in tasks) {
              if (task.id == id) {
                selectedTask = task;
                break;
              }
            }

            if (selectedTask == null) {
              return const Scaffold(
                body: Center(
                  child: Text('Tarea no encontrada'),
                ),
              );
            }

            return TaskDetailScreen(task: selectedTask);
          },
        ),
      ],
    ),
  ],
);

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

// Componente reutilizable
class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        onTap: () {
          context.push('/task/${task.id}');
        },
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
          onPressed: () {
            context.push('/task/${task.id}');
          },
        ),
      ),
    );
  }
}

// Pantalla principal con listado
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
                  return TaskCard(
                    task: tasks[index],
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

// Pantalla de detalle
class TaskDetailScreen extends StatelessWidget {
  final Task task;

  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de tarea'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Descripción',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(task.description),
            const SizedBox(height: 20),
            Text(
              'Prioridad: ${task.priority}',
            ),
            const SizedBox(height: 12),
            Text(
              'Estado: ${task.status}',
            ),
            const SizedBox(height: 24),
            Text(
              'Identificador: ${task.id}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
