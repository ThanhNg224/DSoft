import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_active_bed.dart';
import 'package:spa_project/model/response/model_diagram_room_bed.dart' as dia;

class DiagramRoomBedCubit extends Cubit<DiagramRoomBedState> {
  DiagramRoomBedCubit() : super(InitDiagramRoomBedState());

  void getListDiagramRoomBed(List<dia.Data>? diagram) => emit(state.copyWith(diagram: diagram));

  void getActiveBedDiagramRoomBed(ModelActiveBed? activeBed) => emit(state.copyWith(activeBed: activeBed));
}

class DiagramRoomBedState {
  List<dia.Data> diagram;
  ModelActiveBed? activeBed;

  DiagramRoomBedState({
    this.diagram = const [],
    this.activeBed,
  });

  DiagramRoomBedState copyWith({
    List<dia.Data>? diagram,
    ModelActiveBed? activeBed,
  }) => DiagramRoomBedState(
    diagram: diagram ?? this.diagram,
    activeBed: activeBed ?? this.activeBed,
  );
}

class InitDiagramRoomBedState extends DiagramRoomBedState {}