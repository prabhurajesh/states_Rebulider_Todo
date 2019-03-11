import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:states_rebulid_todo/satesRebulid/todo.dart';

class MainBloc extends StatesRebuilder {
  List<Todo> list = [];
  bool listIsLoading = true;
  List<Todo> get todo => list;
  onSubmit(String s) {
    Todo todo = new Todo(s, false);
    list.add(todo);

    listIsLoading = false;
    rebuildStates(ids: ["ListView"]);
  }

  onCLick(int b, state) {
    list[b].isCompleted = !list[b].isCompleted;
    rebuildStates(states: [state]);
  }

  remove(index) {
    list.removeAt(index);
    rebuildStates(ids: ["ListView"]);
  }
}

MainBloc mainBloc;
