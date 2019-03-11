import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:states_rebulid_todo/satesRebulid/mainBloc.dart';

import 'package:random_color/random_color.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StateBuilder(
      initState: (_) => mainBloc = MainBloc(),
      dispose: (_) => mainBloc = null,
      builder: (_) => MaterialApp(
            title: 'states_rebuilder Example',
            home: MyHomePage('States_Rebuilder ToDo App'),
          ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  String title;
  MyHomePage(this.title);
  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onSubmitted: mainBloc
                          .onSubmit, //on submit of text feild it will call onSubmit function in mainBloc.dart
                    ),
                  ),
                ),
                Container(
                    height: height,
                    child: StateBuilder(
                        stateID:
                            "ListView", //this stateBulider is accesed by sateID
                        blocs: [mainBloc],
                        builder: (State state) {
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: mainBloc.todo.length,
                            itemBuilder: (BuildContext context, int index) {
                              Color _color = _randomColor
                                  .randomColor(); //used for random colouring of the list title
                              return mainBloc.listIsLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : StateBuilder(builder: (state) {
                                      //this stateBulider is accesed by state of widget
                                      return Card(
                                        color: mainBloc.todo[index].isCompleted
                                            ? Colors.blue
                                            : _color,
                                        child: ListTile(
                                            leading: Checkbox(
                                              value: mainBloc
                                                  .todo[index].isCompleted,
                                              onChanged: (bool value) {
                                                mainBloc.onCLick(index, state);
                                              },
                                            ),
                                            title: Text(
                                                mainBloc.todo[index].caption),
                                            trailing: IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                mainBloc.remove(index);
                                              },
                                            )),
                                      );
                                    });
                            },
                          );
                        }))
              ],
            ),
          )),
    );
  }
}
