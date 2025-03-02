import 'package:flutter/material.dart';
import 'package:time_tracker/models/project.dart';


class ProjectTaskProvider with ChangeNotifier {
  final List<Project> _projects = [];

  List<Project> get projects => _projects;

  void addProject(Project project) {
    _projects.add(project);
    notifyListeners();
  }

  void deleteProject(String id) {
    _projects.removeWhere((project) => project.id == id);
    notifyListeners();
  }

  Project? getProjectById(String id) {
    return _projects.firstWhere((project) => project.id == id, orElse: () => Project(id: '', name: 'Unknown'));
  }
}
