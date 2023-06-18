class CrudEvent {}

class CreateEvent<T> extends CrudEvent {

  final T model;

  CreateEvent(this.model);
}

class DeleteEvent extends CrudEvent {

  final int index ;

  DeleteEvent(this.index);
}

class ReadEvent extends CrudEvent {}

class ShowEvent extends CrudEvent {
  final int id;

  ShowEvent(this.id);
}

class UpdateEvent<T> extends CrudEvent {
  final T model;

  UpdateEvent(this.model);
}






