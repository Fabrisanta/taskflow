import '../domain/task.dart';
import 'task_repository.dart';

class LocalTaskRepository implements TaskRepository {
  final List<Task> _tasks = [
    const Task(
      id: 1,
      title: 'Organizar apuntes',
      description: 'Ordenar los apuntes de la semana.',
      priority: 'Baja',
      isCompleted: true, // Marcada como completada
      userId: 1,
    ),
    const Task(
      id: 2,
      title: 'Preparar exposición',
      description: 'Revisar los temas para presentar.',
      priority: 'Media',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 3,
      title: 'Estudiar Flutter',
      description: 'Repasar widgets y layouts.',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 4,
      title: 'Realizar tarea de programación',
      description: 'Completar los ejercicios de clase.',
      priority: 'Alta',
      isCompleted: false,
      userId: 1,
    ),
    const Task(
      id: 5,
      title: 'Leer documentación',
      description: 'Revisar la documentación de Dart.',
      priority: 'Baja',
      isCompleted: false,
      userId: 1,
    ),
  ];

  @override
  List<Task> getTasks() => List.unmodifiable(_tasks);

  @override
  void save(Task task) {
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index == -1) return;
    _tasks[index] = task;
  }
}