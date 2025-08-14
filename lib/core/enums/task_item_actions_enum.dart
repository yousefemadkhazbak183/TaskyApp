enum TaskItemActionsEnum {
  markIsDone(name: "Mark as Done"),
  edit(name: "Edit"),
  delete(name: "Delete");

  final String name;
  const TaskItemActionsEnum({required this.name});
}
