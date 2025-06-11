class SampleData {
  final List<Map<String, dynamic>> data;

  SampleData({required this.data});

  factory SampleData.fromJson(List<dynamic> json) {
    return SampleData(
      data: json.map((e) => Map<String, dynamic>.from(e)).toList(),
    );
  }
}