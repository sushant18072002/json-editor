class EditAction {
  final EditActionType type;
  final String path;
  final dynamic oldValue;
  final dynamic newValue;

  EditAction({
    required this.type,
    required this.path,
    required this.oldValue,
    required this.newValue,
  });
}

enum EditActionType {
  add,
  edit,
  delete,
}



