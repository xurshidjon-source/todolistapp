import 'package:dartz/dartz.dart';
import 'package:todolistapp/core/usecase/usecase.dart';
import 'package:todolistapp/feature/home/data/model/notemodel.dart';
import 'package:todolistapp/feature/home/data/repository/getallnote_repository_implementation.dart';
import 'package:todolistapp/feature/home/domain/repository/getallnote_repository.dart';

import '../../../../service_locator.dart';

class GetAllNoteCase extends UseCase<Either>{
  @override
  Future<NoteModel?> call() async{
    return await sl<GetAllNoteRepositoryImplementation>().getallnotes();
  }




}