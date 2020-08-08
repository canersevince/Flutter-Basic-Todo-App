import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> Todos;
  final Function deleteTodo;
  final Function completeTodo;
  TodoList(this.Todos, this.deleteTodo, this.completeTodo);

  @override
  Widget build(BuildContext context) {
    return Todos.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'Henüz bir görev eklenmemiş.',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.4,
                  child: Column(
                    children: <Widget>[
                      Text("Bu liste boş..."),
                      Icon(Icons.close)
                    ],
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    child: Todos[index].done
                        ? Icon(Icons.check, color: Colors.white)
                        : Icon(Icons.close, color: Colors.white),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Todos[index].done ? Colors.green : Colors.red),
                  ),
                  title: Text(
                    Todos[index].name,
                    style: Theme.of(context).primaryTextTheme.bodyText1,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(Todos[index].created),
                  ),
                  trailing: Container(
                    width: 100,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(50)),
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => deleteTodo(Todos[index]),
                          ),
                        ),
                        if (!Todos[index].done)
                          Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                              icon: Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              color: Theme.of(context).errorColor,
                              onPressed: () => completeTodo(Todos[index].guid),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: Todos.length,
          );
  }
}
