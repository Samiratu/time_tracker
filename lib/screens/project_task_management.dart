import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/project.dart';
import '../models/task.dart';
import '../providers/project_task_provider.dart';

class ProjectTaskManagementScreen extends StatelessWidget {
  const ProjectTaskManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Projects and Tasks'),
      ),
      body: Consumer<ProjectTaskProvider>(
        builder: (context, provider, child) {
          final projects = provider.projects;

          // Ensure the builder returns a widget
          return projects.isEmpty
              ? const Center(child: Text("No projects available"))
              : ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return ListTile(
                      title: Text(project.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => provider.deleteProject(project.id),
                      ),
                    );
                  },
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new project or task
          _showAddProjectDialog(context);
        },
        tooltip: 'Add Project/Task',
        child: Icon(Icons.add),
      ),
    );
  }
}


 void _showAddProjectDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Project"),
        content: TextField(
          controller: _controller,
          decoration: const InputDecoration(labelText: "Project Name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                final newProject = Project(
                  id: DateTime.now().toString(), // Unique ID
                  name: _controller.text,
                );
                Provider.of<ProjectTaskProvider>(context, listen: false)
                    .addProject(newProject);
                Navigator.of(context).pop();
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }