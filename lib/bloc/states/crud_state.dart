enum ProcessType {create , delete , update}

class CrudState {}

class ProcessState extends CrudState {

  final bool success;
  final String message;
  final ProcessType type;

  ProcessState(this.success, this.message, this.type);
}



class ReadState<T> extends CrudState{

  final List<T> data;
  ReadState(this.data);
}


class ShowState<T> extends CrudState{

  final T? object;
  ShowState(this.object);
}

class LoadingState extends CrudState {


}














