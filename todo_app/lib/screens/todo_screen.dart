// lib/screens/todo_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/providers/todo_provider.dart';
import 'package:todo_app/widgets/todo_filters.dart';
import 'package:todo_app/widgets/todo_item.dart';
import 'package:todo_app/widgets/todo_stats.dart';

class TodoScreen extends ConsumerWidget {
  final TextEditingController _controller = TextEditingController();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Key concept: ref.watch() for reactive updates
    final filteredTodos = ref.watch(filteredTodosProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Riverpod Todo Showcase App'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(
          children: [
            // Statistics section
            TodoStatsWidget(),

            // Filter section
            TodoFilters(),

            // Add todo section
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Enter a new todo...',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) => _addTodo(ref, value),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _addTodo(ref, _controller.text),
                    child: Text('Add'),
                  ),
                ],
              ),
            ),

            // Todo list
            Expanded(
              child: filteredTodos.isEmpty
                  ? Center(
                      child: Text(
                        'No todos yet!\nAdd one above to get started.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredTodos.length,
                      itemBuilder: (context, index) {
                        final todo = filteredTodos[index];
                        return TodoItem(todo: todo);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _addTodo(WidgetRef ref, String title) {
    if (title.trim().isNotEmpty) {
      // Key concept: ref.read() for actions (no rebuilding needed)
      ref.read(todoListProvider.notifier).addTodo(title);
      _controller.clear();
    }
  }
}
