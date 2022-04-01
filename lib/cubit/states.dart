abstract class TodoStates{}

class TodoInitialState extends TodoStates{}

class TodogoState extends TodoStates{}

class AppDataBaseCreatedState extends TodoStates{}

class AppDataBaseInsertState extends TodoStates{}

class GetDataLoadingState extends TodoStates{}

class GetDataState extends TodoStates{}

class updateDataState extends TodoStates{}

class deleteDataState extends TodoStates{}




class AppDataBaseInserterror extends TodoStates{
  String error;
  AppDataBaseInserterror(this.error);
}
class GetDataerror extends TodoStates{
  String error;
  GetDataerror(this.error);
}
class appChangeIcon extends TodoStates{}



