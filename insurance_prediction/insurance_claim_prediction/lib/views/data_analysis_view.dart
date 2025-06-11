import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/data_analysis_controller.dart';
import '../models/sample_data.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataAnalysisView extends GetView<DataAnalysisController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'Data Analysis',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.loadData,
            tooltip: 'Refresh Data',
            color: Colors.white,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]!),
                ),
                SizedBox(height: 16),
                Text(
                  'Analyzing Data...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue[800],
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.analysisResult.value == null || controller.sampleData.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.red[400],
                ),
                SizedBox(height: 16),
                Text(
                  'No Data Available',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: controller.loadData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        final analysis = controller.analysisResult.value!;
        final sample = controller.sampleData.value!;

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAnalysisCard(
                title: 'Dataset Summary',
                icon: Icons.summarize,
                color: Colors.blue[600]!,
                child: _buildKeyValueTable(analysis.summary),
              ),

              SizedBox(height: 16),
              Column(
                children: [
                  _buildAnalysisCard(
                    title: 'Missing Values',
                    icon: Icons.find_in_page,
                    color: Colors.red[600]!,
                    child: _buildKeyValueTable(analysis.missingValues),
                  ),
                  SizedBox(height: 16), // Space between the two cards
                  _buildAnalysisCard(
                    title: 'Target Distribution',
                    icon: Icons.pie_chart,
                    color: Colors.green[600]!,
                    child: _buildKeyValueTable(analysis.targetDistribution),
                  ),
                ],
              ),


              SizedBox(height: 16),
              _buildAnalysisCard(
                title: 'Data Types',
                icon: Icons.data_array,
                color: Colors.purple[600]!,
                child: _buildKeyValueTable(analysis.dataTypes),
              ),

              SizedBox(height: 16),
              _buildAnalysisCard(
                title: 'Descriptive Statistics',
                icon: Icons.analytics,
                color: Colors.orange[600]!,
                child: _buildDataGrid(analysis.descriptiveStats),
              ),

              SizedBox(height: 16),
              _buildAnalysisCard(
                title: 'Sample Data (First 5 Rows)',
                icon: Icons.table_rows,
                color: Colors.teal[600]!,
                child: _buildSampleDataTable(sample),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAnalysisCard({
    required String title,
    required IconData icon,
    required Color color,
    required Widget child,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color),
                ),
                SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildKeyValueTable(Map<String, dynamic>? data) {
    if (data == null || data.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        defaultColumnWidth: IntrinsicColumnWidth(),
        border: TableBorder(
          horizontalInside: BorderSide(
            width: 1,
            color: Colors.grey[200]!,
          ),
        ),
        children: data.entries.map((entry) {
          return TableRow(
            decoration: BoxDecoration(
              color: data.entries.toList().indexOf(entry) % 2 == 0
                  ? Colors.grey[50]
                  : Colors.white,
            ),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Text(
                  entry.key,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Text(
                  entry.value.toString(),
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDataGrid(Map<String, dynamic>? data) {
    if (data == null || data.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      );
    }

    final dataGridSource = _DescriptiveStatsDataSource(data);

    return Container(
      height: 300,
      child: SfDataGrid(
        source: dataGridSource,
        columnWidthMode: ColumnWidthMode.fill,
        gridLinesVisibility: GridLinesVisibility.horizontal,
        headerGridLinesVisibility: GridLinesVisibility.horizontal,
        columns: [
          GridColumn(
            columnName: 'feature',
            label: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                'Feature',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          GridColumn(
            columnName: 'mean',
            label: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                'Mean',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          GridColumn(
            columnName: 'std',
            label: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                'Std Dev',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          GridColumn(
            columnName: 'min',
            label: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                'Min',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          GridColumn(
            columnName: 'max',
            label: Container(
              padding: EdgeInsets.all(8),
              child: Text(
                'Max',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSampleDataTable(SampleData sample) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DataTable(
          columns: sample.data.first.keys.map((key) {
            return DataColumn(
              label: Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text(
                  key,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            );
          }).toList(),
          rows: sample.data.take(5).map((row) {
            return DataRow(
              cells: row.values.map((value) {
                return DataCell(
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    child: Text(
                      value.toString(),
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }).toList(),
          dividerThickness: 1,
          dataRowHeight: 48,
          headingRowHeight: 56,
          headingRowColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) => Colors.grey[50]!,
          ),
        ),
      ),
    );
  }
}

class _DescriptiveStatsDataSource extends DataGridSource {
  _DescriptiveStatsDataSource(this.statsData) {
    _buildDataGridRows();
  }

  final Map<String, dynamic> statsData;
  List<DataGridRow> _dataGridRows = [];

  void _buildDataGridRows() {
    _dataGridRows = statsData.entries.map((entry) {
      final stats = entry.value as Map<String, dynamic>;
      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'feature', value: entry.key),
          DataGridCell<double>(columnName: 'mean', value: stats['mean']?.toDouble()),
          DataGridCell<double>(columnName: 'std', value: stats['std']?.toDouble()),
          DataGridCell<double>(columnName: 'min', value: stats['min']?.toDouble()),
          DataGridCell<double>(columnName: 'max', value: stats['max']?.toDouble()),
        ],
      );
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((dataGridCell) {
        return Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(8),
          child: Text(
            dataGridCell.value?.toString() ?? '',
            style: TextStyle(
              color: Colors.grey[800],
            ),
          ),
        );
      }).toList(),
    );
  }


}