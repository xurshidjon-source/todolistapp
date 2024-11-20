import 'package:get_it/get_it.dart';
import 'package:todolistapp/core/usecase/usecase.dart';
import 'package:todolistapp/feature/home/data/repository/getallnote_repository_implementation.dart';
import 'package:todolistapp/feature/home/domain/repository/getallnote_repository.dart';
import 'package:todolistapp/feature/home/domain/usecases/getallnote_usecase.dart';

var sl=GetIt.instance;
void setuplocator(){
  sl.registerSingleton<GetAllNoteCase>(GetAllNoteCase());
  sl.registerSingleton<GetAllNoteRepositoryImplementation>(GetAllNoteRepositoryImplementation());



}