//Packages
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

// Model import

import './model/todo.dart';

// Custom Styles
import './theme//theme.dart';

//Widgets
import './widgets/todo_list.dart';
import './widgets/new_todo.dart';

void main() {
  runApp(App());
}

var uuid = Uuid();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yapılacaklar Listesi',
      theme: MainTheme(),
      home: Home(title: 'Yapılacaklar Listesi'),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AppState createState() => _AppState();
}

List<Todo> Todos = [
  Todo("fasc3", 'Test 1', DateTime.now(), DateTime.now(), true),
  Todo("fasc2", 'Test 2', DateTime.now(), DateTime.now(), true),
  Todo("fasc4", 'Test 3', DateTime.now(), DateTime.now(), false),
  Todo("fasc5", 'Test 4', DateTime.now(), DateTime.now(), false),
  Todo("fasc6", 'Test 5', DateTime.now(), DateTime.now(), false),
];

class _AppState extends State<Home> {
  List<Todo> _unCompleted;

  List<Todo> _Completed;

  splitByDone() {
    setState(() {
      _unCompleted = Todos.where((element) => !element.done).toList();

      _Completed = Todos.where((element) => element.done).toList();
    });
  }

  void _showNewTodo(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTodo(_addTodo),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  _addTodo(title, target) {
    Todo Temp = Todo(uuid.v4(), title, DateTime.now(), target, false);
    setState(() {
      Todos.add(Temp);
    });
  }

  _completeTodo(guid) {
    setState(() {
      var elem = Todos.where((element) => element.guid == guid);
      elem.toList().elementAt(0).done = true;
    });
  }

  _deleteTodo(Todo todo) {
    setState(() {
      Todos.removeWhere((element) => element.guid == todo.guid);
    });
  }

  @override
  Widget build(BuildContext context) {
    splitByDone();
    final appBar = AppBar(
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _showNewTodo(context);
          },
        )
      ],
    );

    // generates responsive height for lists.
    todoListHeightGen(completed, isLandScape, context) {
      if (isLandScape) {
        if (completed) {
          if (_Completed.length == 0) {
            return (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0;
          } else {
            if (_unCompleted.length == 0) {
              return (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.9;
            }
            return (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.4;
          }
        } else {
          if (_unCompleted.length == 0) {
            return (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0;
          } else {
            if (_Completed.length == 0) {
              return (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.9;
            }
            return (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.4;
          }
        }
      } else {
        if (completed) {
          if (_Completed.length == 0) {
            return (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0;
          } else {
            if (_unCompleted.length == 0) {
              return (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.9;
            }
            return (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.5;
          }
        } else {
          if (_unCompleted.length == 0) {
            return (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0;
          } else {
            if (_Completed.length == 0) {
              return (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.9;
            }
            return (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.5;
          }
        }
      }
    }

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final todoListWidget = Container(
      height: todoListHeightGen(false, isLandscape, context),
      child: TodoList(_unCompleted, _deleteTodo, _completeTodo),
    );
    final uncompletedTodoListWidget = Container(
      height: todoListHeightGen(true, isLandscape, context),
      child: TodoList(_Completed, _deleteTodo, _completeTodo),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_unCompleted.length > 0)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  "Tamamlanmamış",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            todoListWidget,
            if (_Completed.length > 0)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  "Tamamlanmış",
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                ),
              ),
            uncompletedTodoListWidget
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewTodo(context);
        },
        tooltip: '',
        child: Icon(Icons.add),
      ),
    );
  }
}
