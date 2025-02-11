import 'package:get/get.dart';
import '../../../../entities/history/edit_action.dart';
import '../../../../entities/json/json_node.dart';
import '../../../../shared/mixins/loading_mixin.dart';
import '../../domain/usecases/crud/add_node_usecase.dart';
import '../../domain/usecases/crud/delete_node_usecase.dart';
import '../../domain/usecases/crud/edit_node_usecase.dart';
import '../../domain/usecases/load_json_usecase.dart';
import '../../domain/usecases/save_json_usecase.dart';
import '../../domain/usecases/undo_redo_usecase.dart';
import '../widgets/editor.dart';

class JsonEditorController extends GetxController with LoadingMixin {
  final LoadJsonUseCase _loadJsonUseCase;
  final SaveJsonUseCase _saveJsonUseCase;
  final EditNodeUseCase _editNodeUseCase;
  
  final Rx<JsonNode?> _currentNode = Rx<JsonNode?>(null);
  final RxString _selectedPath = ''.obs;
  final RxList<EditAction> _history = RxList<EditAction>([]);
  final RxInt _historyIndex = RxInt(-1);
  
  JsonNode? get currentNode => _currentNode.value;
  String get selectedPath => _selectedPath.value;
  bool get canUndo => _historyIndex.value > -1;
  bool get canRedo => _historyIndex.value < _history.length - 1;

  JsonEditorController({
    required LoadJsonUseCase loadJsonUseCase,
    required SaveJsonUseCase saveJsonUseCase,
    required EditNodeUseCase editNodeUseCase,
  }) : _loadJsonUseCase = loadJsonUseCase,
       _saveJsonUseCase = saveJsonUseCase,
       _editNodeUseCase = editNodeUseCase;

  Future<void> loadJson(String key) async {
    try {
      setLoading(true);
      final node = await _loadJsonUseCase.execute(key);
      
      _currentNode.value = JsonNode(data: {
          "uuid": "550e8400-e29b-41d4-a716-446655440000",
          "translations": {
            "en": {
              "title": "Morning Blessing",
              "description": "Perfect template for sharing morning blessings",
              "greeting": "Good Morning! May your day be filled with peace and joy.",
              "semantic_label": "Buddhist temple at sunrise with golden sky"
            },
            "hi": {
              "title": "प्रभाती आशीर्वाद",
              "description": "सुबह का आशीर्वाद साझा करने के लिए उत्तम टेम्पलेट",
              "greeting": "सुप्रभात! आपका दिन शांति और आनंद से भरा हो।",
              "semantic_label": "सुनहरे आसमान के साथ सूर्योदय में बौद्ध मंदिर"
            }
          },
          "composition": {
            "background_id": "bg001",
            "quote_id": "550e8400-e29b-41d4-a716-446655440000",
            "layout": "vertical",
            "aspect_ratio": "9:16"
          },
          "layout_config": {
            "responsive": true,
            "breakpoints": {
              "small": 600,
              "medium": 900,
              "large": 1200
            },
            "portrait": {
              "title": {
                "position": {
                  "x": 50,
                  "y": 20
                },
                "size": {
                  "width": 85,
                  "height": 15
                },
                "padding": 16,
                "safe_area": {
                  "top": 44,
                  "bottom": 34
                },
                "visual_effects": {
                  "blur": {
                    "enabled": true,
                    "sigma": {
                      "x": {
                        "base": 2,
                        "min": 1,
                        "max": 5
                      },
                      "y": {
                        "base": 2,
                        "min": 1,
                        "max": 5
                      }
                    },
                    "quality": "high"
                  },
                  "border_radius": {
                    "base": 8,
                    "min": 4,
                    "max": 16,
                    "scale_factor": 1.2
                  },
                  "background": {
                    "opacity": {
                      "base": 0.3,
                      "min": 0.1,
                      "max": 0.5
                    },
                    "color": "0xFF000000"
                  }
                }
              },
              "quote": {
                "position": {
                  "x": 50,
                  "y": 60
                },
                "size": {
                  "width": 80,
                  "height": 30
                },
                "padding": 16,
                "visual_effects": {
                  "blur": {
                    "enabled": false,
                    "sigma": {
                      "x": {
                        "base": 2,
                        "min": 1,
                        "max": 5
                      },
                      "y": {
                        "base": 2,
                        "min": 1,
                        "max": 5
                      }
                    },
                    "quality": "high"
                  },
                  "border_radius": {
                    "base": 8,
                    "min": 4,
                    "max": 16,
                    "scale_factor": 1.2
                  },
                  "background": {
                    "opacity": {
                      "base": 0.2,
                      "min": 0.1,
                      "max": 0.4
                    },
                    "color": "0xFF000000"
                  }
                }
              }
            },
            "landscape": {
              "title": {
                "position": {
                  "x": 50,
                  "y": 15
                },
                "size": {
                  "width": 70,
                  "height": 20
                },
                "padding": 16,
                "safe_area": {
                  "top": 0,
                  "bottom": 21
                },
                "visual_effects": {
                  "blur": {
                    "enabled": true,
                    "sigma": {
                      "x": {
                        "base": 2.5,
                        "min": 1,
                        "max": 5
                      },
                      "y": {
                        "base": 2.5,
                        "min": 1,
                        "max": 5
                      }
                    },
                    "quality": "high"
                  },
                  "border_radius": {
                    "base": 10,
                    "min": 6,
                    "max": 20,
                    "scale_factor": 1.3
                  },
                  "background": {
                    "opacity": {
                      "base": 0.25,
                      "min": 0.1,
                      "max": 0.4
                    },
                    "color": "0xFF000000"
                  }
                }
              },
              "quote": {
                "position": {
                  "x": 50,
                  "y": 50
                },
                "size": {
                  "width": 65,
                  "height": 35
                },
                "padding": 16,
                "visual_effects": {
                  "blur": {
                    "enabled": true,
                    "sigma": {
                      "x": {
                        "base": 2.5,
                        "min": 1,
                        "max": 5
                      },
                      "y": {
                        "base": 2.5,
                        "min": 1,
                        "max": 5
                      }
                    },
                    "quality": "high"
                  },
                  "border_radius": {
                    "base": 10,
                    "min": 6,
                    "max": 20,
                    "scale_factor": 1.3
                  },
                  "background": {
                    "opacity": {
                      "base": 0.15,
                      "min": 0.1,
                      "max": 0.3
                    },
                    "color": "0xFF000000"
                  }
                }
              },
              "layout_adjustments": {
                "spacing": {
                  "between_elements": 24,
                  "horizontal_margin": 32,
                  "vertical_margin": 16
                },
                "alignment": {
                  "title": "center",
                  "quote": "center"
                },
                "constraints": {
                  "max_width": {
                    "title": 800,
                    "quote": 1000
                  },
                  "min_height": {
                    "title": 60,
                    "quote": 100
                  }
                }
              },
              "responsive_behavior": {
                "breakpoints": {
                  "small": {
                    "max_width": 800,
                    "title_scale": 0.8,
                    "quote_scale": 0.85,
                    "spacing_scale": 0.9
                  },
                  "medium": {
                    "max_width": 1200,
                    "title_scale": 0.9,
                    "quote_scale": 0.95,
                    "spacing_scale": 1.0
                  },
                  "large": {
                    "max_width": 1600,
                    "title_scale": 1.0,
                    "quote_scale": 1.0,
                    "spacing_scale": 1.1
                  }
                }
              }
            }
          },
          "style_config": {
            "common": {
              "gradient_overlay": {
                "enabled": true,
                "stops": [
                  {
                    "color": "0x00000000",
                    "position": 0.4
                  },
                  {
                    "color": "0xB3000000",
                    "position": 1.0
                  }
                ],
                "angle": 180
              },
              "animations": {
                "transition_duration": 300,
                "hover": {
                  "scale": 1.02,
                  "duration": 200
                }
              }
            },
            "title": {
              "typography": {
                "font_family": "Poppins",
                "font_size": {
                  "base": 16,
                  "min": 12,
                  "max": 18,
                  "scale": 0.05
                },
                "font_weight": "600",
                "letter_spacing": 0.5,
                "line_height": 1.5,
                "text_align": "center",
                "text_transform": "uppercase"
              },
              "colors": {
                "text": "0xFF333333",
                "shadow": {
                  "color": "0x80000000",
                  "offset": {
                    "x": 0,
                    "y": 1
                  },
                  "blur_radius": 2,
                  "opacity": 0.5
                }
              }
            },
            "quote": {
              "typography": {
                "font_family": "Poppins",
                "font_size": {
                  "base": 24,
                  "min": 16,
                  "max": 36,
                  "scale": 0.05
                },
                "font_weight": "400",
                "letter_spacing": 0.5,
                "line_height": 1.6,
                "text_align": "center",
                "text_transform": "none"
              },
              "colors": {
                "text": "0xFF333333",
                "shadow": {
                  "color": "0x80000000",
                  "offset": {
                    "x": 0,
                    "y": 1
                  },
                  "blur_radius": 2,
                  "opacity": 0.5
                }
              }
            },
            "action_buttons": {
              "size": 20,
              "background": {
                "opacity": 0.3,
                "color": "0xFF000000"
              },
              "blur": {
                "enabled": true,
                "sigma": {
                  "x": 3,
                  "y": 3
                }
              },
              "shadow": {
                "color": "0x33000000",
                "offset": {
                  "x": 0,
                  "y": 2
                },
                "blur_radius": 4
              }
            }
          },
          "responsive_config": {
            "grid": {
              "spacing": {
                "small": 12,
                "medium": 16,
                "large": 20
              },
              "columns": {
                "small": 2,
                "medium": 3,
                "large": 4,
                "xlarge": 5
              }
            }
          },
          "category_ids": [
            "temples",
            "nature"
          ],
          "tag_ids": [
            "tag_time_001",
            "tag_time_002"
          ],
          "metadata": {
            "is_premium": false,
            "status": "active",
            "version": 1
          },
          "metrics": {
            "views": 0,
            "shares": 0,
            "favorites": 0,
            "last_used": null
          },
          "audit": {
            "created_at": "2024-01-02T00:00:00Z",
            "created_by": "system",
            "modified_at": "2024-01-02T00:00:00Z",
            "modified_by": "system",
            "version": 1
          }
        });
      _clearHistory();
    } catch (e) {
      throw Exception('Failed to load JSON: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> saveJson(String key) async {
    try {
      setLoading(true);
      if (_currentNode.value != null) {
        await _saveJsonUseCase.execute(key, _currentNode.value!);
      }
    } catch (e) {
      throw Exception('Failed to save JSON: $e');
    } finally {
      setLoading(false);
    }
  }

  void editNode(String path, dynamic newValue) {
    if (_currentNode.value == null) return;
    
    final oldNode = _currentNode.value!;
    final newNode = _editNodeUseCase.execute(oldNode, path, newValue);
    
    _addToHistory(EditAction(
      type: EditActionType.add,
      path: path,
      oldValue: oldNode,
      newValue: newNode
    ));
    
    _currentNode.value = newNode;
  }

  void undo() {
    if (!canUndo) return;
    
    final action = _history[_historyIndex.value];
    _currentNode.value = action.oldValue as JsonNode;
    _historyIndex.value--;
  }

  void redo() {
    if (!canRedo) return;
    
    _historyIndex.value++;
    final action = _history[_historyIndex.value];
    _currentNode.value = action.newValue as JsonNode;
  }

  void _addToHistory(EditAction action) {
    // Remove any redo actions
    if (_historyIndex.value < _history.length - 1) {
      _history.removeRange(_historyIndex.value + 1, _history.length);
    }
    
    _history.add(action);
    _historyIndex.value = _history.length - 1;
  }

  void _clearHistory() {
    _history.clear();
    _historyIndex.value = -1;
  }
   void setSelectedPath(String path) {
    _selectedPath.value = path;
  }
}