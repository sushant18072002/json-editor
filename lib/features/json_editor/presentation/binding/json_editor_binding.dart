import 'package:get/get.dart';
import 'package:json_editor/features/json_editor/presentation/controllers/json_editor_controller.dart';

import '../../../../core/network/api_provider.dart';
import '../../../../core/repositories/json_repository_impl.dart';
import '../../../../core/storage/local_storage.dart';
import '../../domain/repositories/json_repository.dart';
import '../../domain/usecases/crud/add_node_usecase.dart';
import '../../domain/usecases/crud/delete_node_usecase.dart';
import '../../domain/usecases/crud/edit_node_usecase.dart';
import '../../domain/usecases/load_json_usecase.dart';
import '../../domain/usecases/save_json_usecase.dart';
import '../../domain/usecases/undo_redo_usecase.dart';

class JsonEditorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<LocalStorage>(() => LocalStorage());

    // Registering Repository Implementation
    Get.lazyPut<JsonRepository>(
      () => JsonRepositoryImpl(
        Get.find<ApiProvider>(),
        Get.find<LocalStorage>(),
      ),
    );

// Registering Use Cases
    Get.lazyPut<LoadJsonUseCase>(
        () => LoadJsonUseCase(Get.find<JsonRepository>()));
    Get.lazyPut<SaveJsonUseCase>(
        () => SaveJsonUseCase(Get.find<JsonRepository>()));
    Get.lazyPut<AddNodeUseCase>(() => AddNodeUseCase());
    Get.lazyPut<EditNodeUseCase>(() => EditNodeUseCase());
    Get.lazyPut<DeleteNodeUseCase>(() => DeleteNodeUseCase());
    Get.lazyPut<UndoRedoUseCase>(() => UndoRedoUseCase());

    // Registering Controllers
    Get.lazyPut<JsonEditorController>(() => JsonEditorController(
          loadJsonUseCase: Get.find<LoadJsonUseCase>(),
          saveJsonUseCase: Get.find<SaveJsonUseCase>(),
          
          editNodeUseCase: Get.find<EditNodeUseCase>(),
         
        ));
  }
}
