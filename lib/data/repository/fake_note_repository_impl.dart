import 'package:note_app/core/result.dart';
import 'package:note_app/data/data_source/local/note_data_source.dart';
import 'package:note_app/domain/model/note.dart';
import 'package:note_app/domain/repository/note_repository.dart';
import 'package:note_app/ui/colors.dart';

class FakeNoteRepositoryImpl implements NoteRepository {
  NoteDataSource dataSource;

  FakeNoteRepositoryImpl(this.dataSource);

  @override
  Future<void> deleteNote(Note note) async {
    await dataSource.deleteNote(note);
  }

  @override
  Future<Result<Note>> getNoteById(int id) async {
    Note? note = await dataSource.getNoteById(id);

    if (note != null) {
      return Result.success(note);
    }

    return const Result.error('노트가 없습니다');
  }

  @override
  Future<List<Note>> getNotes() async {
    return [
      Note(timestamp: 2000, content: 'fake 내용 입니다1.', title: 'test1', color: skyBlue.value),
      Note(timestamp: 3000, content: 'fake 내용 입니다2.', title: 'test2', color: roseBud.value),
      Note(timestamp: 4000, content: 'fake 내용 입니다3.', title: 'test3', color: primrose.value),
      Note(timestamp: 5000, content: 'fake 내용 입니다4.', title: 'test4', color: illusion.value),
      Note(timestamp: 6000, content: 'fake 내용 입니다5.', title: 'test5', color: wisteria.value),
      Note(timestamp: 7000, content: 'fake 내용 입니다6.', title: 'test6', color: skyBlue.value),
      Note(timestamp: 8000, content: 'fake 내용 입니다7.', title: 'test7', color: roseBud.value),
      Note(timestamp: 9000, content: 'fake 내용 입니다8.', title: 'test8', color: primrose.value),
      Note(timestamp: 10000, content: 'fake 내용 입니다9.', title: 'test9', color: illusion.value),
      Note(timestamp: 11000, content: 'fake 내용 입니다10.', title: 'test10', color: wisteria.value),
    ];
  }

  @override
  Future<void> insertNote(Note note) async {
    await dataSource.insertNote(note);
  }

  @override
  Future<void> updateNote(Note note) async {
    await dataSource.updateNote(note);
  }
}
