import 'package:dartz/dartz.dart';
import 'package:todolistapp/feature/home/data/model/notemodel.dart';

abstract class UseCase<Type>{
  Future<NoteModel?> call();

}