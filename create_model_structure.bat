@echo off
:: Base directory
set "base_dir=lib"

:: Create main directories
mkdir "%base_dir%\app"
mkdir "%base_dir%\app\bindings"
mkdir "%base_dir%\app\routes"
mkdir "%base_dir%\app\theme"
mkdir "%base_dir%\app\theme\localization"

mkdir "%base_dir%\core"
mkdir "%base_dir%\core\network"
mkdir "%base_dir%\core\storage"
mkdir "%base_dir%\core\repositories"
mkdir "%base_dir%\core\utils"

mkdir "%base_dir%\entities"
mkdir "%base_dir%\entities\json"
mkdir "%base_dir%\entities\comparison"
mkdir "%base_dir%\entities\history"

mkdir "%base_dir%\features"
mkdir "%base_dir%\features\splash"
mkdir "%base_dir%\features\splash\presentation"
mkdir "%base_dir%\features\splash\presentation\controllers"
mkdir "%base_dir%\features\splash\presentation\pages"

mkdir "%base_dir%\features\home"
mkdir "%base_dir%\features\home\presentation"
mkdir "%base_dir%\features\home\presentation\controllers"
mkdir "%base_dir%\features\home\presentation\pages"

mkdir "%base_dir%\features\json_editor"
mkdir "%base_dir%\features\json_editor\data"
mkdir "%base_dir%\features\json_editor\data\datasources"
mkdir "%base_dir%\features\json_editor\data\models"
mkdir "%base_dir%\features\json_editor\data\repositories"
mkdir "%base_dir%\features\json_editor\domain"
mkdir "%base_dir%\features\json_editor\domain\repositories"
mkdir "%base_dir%\features\json_editor\domain\usecases"
mkdir "%base_dir%\features\json_editor\domain\usecases\crud"
mkdir "%base_dir%\features\json_editor\presentation"
mkdir "%base_dir%\features\json_editor\presentation\controllers"
mkdir "%base_dir%\features\json_editor\presentation\widgets"
mkdir "%base_dir%\features\json_editor\presentation\pages"

mkdir "%base_dir%\features\json_comparison"
mkdir "%base_dir%\features\json_comparison\data"
mkdir "%base_dir%\features\json_comparison\data\models"
mkdir "%base_dir%\features\json_comparison\data\repositories"
mkdir "%base_dir%\features\json_comparison\domain"
mkdir "%base_dir%\features\json_comparison\domain\repositories"
mkdir "%base_dir%\features\json_comparison\domain\usecases"
mkdir "%base_dir%\features\json_comparison\presentation"
mkdir "%base_dir%\features\json_comparison\presentation\controllers"
mkdir "%base_dir%\features\json_comparison\presentation\widgets"
mkdir "%base_dir%\features\json_comparison\presentation\pages"

mkdir "%base_dir%\features\settings"
mkdir "%base_dir%\features\settings\presentation"
mkdir "%base_dir%\features\settings\presentation\controllers"
mkdir "%base_dir%\features\settings\presentation\pages"

mkdir "%base_dir%\shared"
mkdir "%base_dir%\shared\widgets"
mkdir "%base_dir%\shared\widgets\interactive"
mkdir "%base_dir%\shared\services"
mkdir "%base_dir%\shared\mixins"

:: Create files
:: App
type nul > "%base_dir%\app\bindings\initial_binding.dart"
type nul > "%base_dir%\app\routes\app_pages.dart"
type nul > "%base_dir%\app\routes\app_routes.dart"
type nul > "%base_dir%\app\theme\app_theme.dart"
type nul > "%base_dir%\app\theme\theme_manager.dart"
type nul > "%base_dir%\app\theme\localization\app_localizations.dart"
type nul > "%base_dir%\app\theme\localization\en.json"
type nul > "%base_dir%\app\theme\localization\es.json"

:: Core
type nul > "%base_dir%\core\network\api_provider.dart"
type nul > "%base_dir%\core\network\api_endpoints.dart"
type nul > "%base_dir%\core\network\network_info.dart"
type nul > "%base_dir%\core\storage\local_storage.dart"
type nul > "%base_dir%\core\storage\secure_storage.dart"
type nul > "%base_dir%\core\repositories\json_repository_impl.dart"
type nul > "%base_dir%\core\repositories\schema_repository_impl.dart"
type nul > "%base_dir%\core\repositories\history_repository_impl.dart"
type nul > "%base_dir%\core\utils\constants.dart"
type nul > "%base_dir%\core\utils\validators.dart"
type nul > "%base_dir%\core\utils\error_handlers.dart"
type nul > "%base_dir%\core\utils\json_path_utils.dart"

:: Entities
type nul > "%base_dir%\entities\json\json_node.dart"
type nul > "%base_dir%\entities\json\json_schema.dart"
type nul > "%base_dir%\entities\json\json_error.dart"
type nul > "%base_dir%\entities\comparison\json_diff.dart"
type nul > "%base_dir%\entities\comparison\comparison_result.dart"
type nul > "%base_dir%\entities\history\edit_action.dart"

:: Features - Splash
type nul > "%base_dir%\features\splash\presentation\controllers\splash_controller.dart"
type nul > "%base_dir%\features\splash\presentation\pages\splash_page.dart"

:: Features - Home
type nul > "%base_dir%\features\home\presentation\controllers\home_controller.dart"
type nul > "%base_dir%\features\home\presentation\pages\home_page.dart"

:: Features - Json Editor
type nul > "%base_dir%\features\json_editor\data\datasources\json_local_datasource.dart"
type nul > "%base_dir%\features\json_editor\data\models\json_model.dart"
type nul > "%base_dir%\features\json_editor\data\models\schema_model.dart"
type nul > "%base_dir%\features\json_editor\data\repositories\json_repository_impl.dart"
type nul > "%base_dir%\features\json_editor\domain\repositories\json_repository.dart"
type nul > "%base_dir%\features\json_editor\domain\usecases\crud\add_node_usecase.dart"
type nul > "%base_dir%\features\json_editor\domain\usecases\crud\edit_node_usecase.dart"
type nul > "%base_dir%\features\json_editor\domain\usecases\crud\delete_node_usecase.dart"
type nul > "%base_dir%\features\json_editor\domain\usecases\load_json_usecase.dart"
type nul > "%base_dir%\features\json_editor\domain\usecases\save_json_usecase.dart"
type nul > "%base_dir%\features\json_editor\domain\usecases\validate_json_usecase.dart"
type nul > "%base_dir%\features\json_editor\domain\usecases\search_json_usecase.dart"
type nul > "%base_dir%\features\json_editor\domain\usecases\undo_redo_usecase.dart"
type nul > "%base_dir%\features\json_editor\presentation\controllers\json_editor_controller.dart"
type nul > "%base_dir%\features\json_editor\presentation\controllers\schema_controller.dart"
type nul > "%base_dir%\features\json_editor\presentation\widgets\node_context_menu.dart"
type nul > "%base_dir%\features\json_editor\presentation\widgets\json_type_selector.dart"
type nul > "%base_dir%\features\json_editor\presentation\pages\json_editor_page.dart"
type nul > "%base_dir%\features\json_editor\presentation\pages\schema_validation_page.dart"
type nul > "%base_dir%\features\json_editor\presentation\pages\bookmarks_page.dart"

:: Features - Json Comparison
type nul > "%base_dir%\features\json_comparison\data\models\json_comparison_model.dart"
type nul > "%base_dir%\features\json_comparison\data\repositories\json_comparison_repository_impl.dart"
type nul > "%base_dir%\features\json_comparison\domain\repositories\json_comparison_repository.dart"
type nul > "%base_dir%\features\json_comparison\domain\usecases\compare_json_usecase.dart"
type nul > "%base_dir%\features\json_comparison\domain\usecases\merge_json_usecase.dart"
type nul > "%base_dir%\features\json_comparison\presentation\controllers\json_comparison_controller.dart"
type nul > "%base_dir%\features\json_comparison\presentation\widgets\split_view_comparator.dart"
type nul > "%base_dir%\features\json_comparison\presentation\pages\json_comparison_page.dart"
type nul > "%base_dir%\features\json_comparison\presentation\pages\merge_results_page.dart"

:: Features - Settings
type nul > "%base_dir%\features\settings\presentation\controllers\settings_controller.dart"
type nul > "%base_dir%\features\settings\presentation\pages\settings_page.dart"
type nul > "%base_dir%\features\settings\presentation\pages\theme_settings_page.dart"
type nul > "%base_dir%\features\settings\presentation\pages\language_settings_page.dart"

:: Shared
type nul > "%base_dir%\shared\widgets\interactive\draggable_json_node.dart"
type nul > "%base_dir%\shared\widgets\interactive\collapsible_tree_node.dart"
type nul > "%base_dir%\shared\widgets\json_tree_view.dart"
type nul > "%base_dir%\shared\widgets\json_syntax_highlighter.dart"
type nul > "%base_dir%\shared\widgets\json_breadcrumbs.dart"
type nul > "%base_dir%\shared\widgets\virtual_scroller.dart"
type nul > "%base_dir%\shared\widgets\custom_button.dart"
type nul > "%base_dir%\shared\widgets\custom_text_field.dart"
type nul > "%base_dir%\shared\widgets\custom_dropdown.dart"
type nul > "%base_dir%\shared\widgets\error_card.dart"
type nul > "%base_dir%\shared\widgets\search_result_card.dart"
type nul > "%base_dir%\shared\widgets\comparison_result_card.dart"
type nul > "%base_dir%\shared\services\json_parser_service.dart"
type nul > "%base_dir%\shared\services\schema_validator_service.dart"
type nul > "%base_dir%\shared\services\search_service.dart"
type nul > "%base_dir%\shared\services\comparison_service.dart"
type nul > "%base_dir%\shared\services\history_service.dart"
type nul > "%base_dir%\shared\mixins\crud_operations_mixin.dart"
type nul > "%base_dir%\shared\mixins\loading_mixin.dart"
type nul > "%base_dir%\shared\mixins\validation_mixin.dart"

:: Main file
type nul > "%base_dir%\main.dart"

echo Folder structure created successfully.