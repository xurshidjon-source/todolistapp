import 'package:dartz/dartz.dart';
import 'package:todolistapp/feature/home/data/model/notemodel.dart';

abstract class  GetAllRepository{
  Future<NoteModel?> getallnotes();
}