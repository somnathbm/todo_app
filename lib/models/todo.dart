class Todo {
  // members
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  // default unnamed constructor
  Todo(this._title, this._priority, this._date, [this._description]);

  // a named constructor
  Todo.withId(this._id, this._title, this._priority, this._date, [this._description]);

  // yet another named constructor
  Todo.fromObject(dynamic o) {
    this._id = o['id'];
    this._title = o['title'];
    this._description = o['description'];
    this._date = o['date'];
    this._priority = o['priority'];
  }

  // Getters
  int get getId => _id;
  String get getTitle => _title;
  String get getDescription => _description;
  String get getDate => _date;
  int get getPriority => _priority;

  // Setters
  set setTitle(String newTitle) {
    if (newTitle.length <= 255) {
      _title = newTitle;
    }
  }

  set setDescription(String newDescription) {
    if (newDescription.length <= 255) {
      _description = newDescription;
    }
  }

  set setDate(String newDate) {
    _date = newDate;
  }

  set setPriority(int newPriority) {
    if (newPriority > 0 && newPriority <= 3) {
      _priority = newPriority;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;
    map['priority'] = _priority;
    if (_id != null) {
      map['id'] = _id;
    }
    return map;
  }
}