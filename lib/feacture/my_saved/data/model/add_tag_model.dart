import 'package:equatable/equatable.dart';

class AddTagModel extends Equatable {
  final String label;
  final bool isChecked;

  AddTagModel({
    this.label,
    this.isChecked,
  });

  AddTagModel copyWith({
    String label,
    bool isChecked,
  }) {
    return AddTagModel(
      isChecked: isChecked ?? this.isChecked,
      label: label ?? this.label,
    );
  }

  @override
  List<Object> get props => [
        label,
        isChecked,
      ];
}
