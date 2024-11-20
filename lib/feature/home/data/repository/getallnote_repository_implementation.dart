import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/api_url.dart';
import '../../domain/repository/getallnote_repository.dart';
import '../model/notemodel.dart';

class GetAllNoteRepositoryImplementation extends GetAllRepository {
  @override
  Future<NoteModel?> getallnotes() async {
    Dio dio = Dio();
    try {
      // Make a GET request
      Response response = await dio.get(ApiUrl.allnotes);

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Handle the response data
        print('Data fetched successfully:');
        print(response.data);

        if (response.data != null) {
          if (response.data is Map<String, dynamic>) {
            // Convert the response data to NoteModel
            NoteModel noteModel = NoteModel.fromJson(response.data);

            // Store the data in Hive
            await _storeNoteToHive(noteModel);

            return noteModel;
          } else {
            print('Error: Unexpected data format');
            return null;
          }
        } else {
          print('Error: Response data is null');
          return null;
        }
      } else {
        print('Error: Failed to fetch data, StatusCode: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Function to store the fetched NoteModel data in Hive
  Future<void> _storeNoteToHive(NoteModel noteModel) async {
    try {
      // Open the Hive box
      var box = await Hive.openBox<NoteModel>('noteBox');

      // Store the data (add the new NoteModel)
      await box.put('noteKey', noteModel); // Here we store it using a static key

      print('NoteModel data saved to Hive successfully!');
    } catch (e) {
      print('Error saving data to Hive: $e');
    }
  }
}
