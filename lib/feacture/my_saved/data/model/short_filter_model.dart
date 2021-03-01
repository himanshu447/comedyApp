
class ShortAndFilterModel{
  final String label;
  final bool isChecked;

  ShortAndFilterModel({
    this.label,
    this.isChecked,
  });

  ShortAndFilterModel copyWith({
    String label,
    bool isChecked,
  }) {
    return ShortAndFilterModel(
      isChecked: isChecked ?? this.isChecked,
      label: label ?? this.label,
    );
  }
}
