import 'package:helpnow_assignment/models/form.dart';
import 'package:helpnow_assignment/database/repository.dart';

class FormService {
  Repository _repository;
  FormService() {
    _repository = Repository();
  }
  saveForm(FormData form) async {
    return await _repository.insertData('forms', form.formMap());
  }

  readForms() async {
    return await _repository.readData('forms');
  }
}
