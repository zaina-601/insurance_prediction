class AnalysisResult {
  final Map<String, dynamic> summary;
  final Map<String, dynamic>? missingValues;
  final Map<String, dynamic>? targetDistribution;
  final Map<String, dynamic>? dataTypes;
  final Map<String, dynamic>? groupDistribution;
  final List<Map<String, dynamic>> sampleData;
  final Map<String, dynamic>? descriptiveStats;

  AnalysisResult({
    required this.summary,
    this.missingValues,
    this.targetDistribution,
    this.dataTypes,
    this.groupDistribution,
    required this.sampleData,
    this.descriptiveStats,
  });

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    return AnalysisResult(
      summary: Map<String, dynamic>.from(json['summary'] ?? {}),
      missingValues: json['summary']?['missing_values'] != null
          ? Map<String, dynamic>.from(json['summary']['missing_values'])
          : null,
      targetDistribution: json['summary']?['target_distribution'] != null
          ? Map<String, dynamic>.from(json['summary']['target_distribution'])
          : null,
      dataTypes: json['summary']?['data_types'] != null
          ? Map<String, dynamic>.from(json['summary']['data_types'])
          : null,
      groupDistribution: null, // Not present in your JSON
      sampleData: (json['sample_data'] as List<dynamic>?)
          ?.map((e) => Map<String, dynamic>.from(e))
          .toList() ?? [],
      descriptiveStats: json['summary']?['feature_stats'] != null
          ? Map<String, dynamic>.from(json['summary']['feature_stats'])
          : null,
    );
  }
}