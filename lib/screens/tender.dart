import 'package:flutter/material.dart';
import 'package:erp_1/models/tenderModel.dart'; // Adjust path
import 'package:erp_1/utils/tenderService.dart'; // Adjust path
import 'package:erp_1/widgets/tender_title.dart'; // Adjust path
import 'package:erp_1/widgets/appBar.dart'; // Import CustomScaffold
import 'package:erp_1/screens/CreateTender.dart'; // Import the create tender screen
import 'package:erp_1/screens/tenderDetail.dart'; // Import TenderDetailScreen

class TenderScreen extends StatefulWidget {
  @override
  _TenderScreenState createState() => _TenderScreenState();
}

class _TenderScreenState extends State<TenderScreen> {
  List<Tender>? tenderList;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTenders();
  }

  // Method to fetch tenders
  Future<void> _fetchTenders() async {
    setState(() {
      _isLoading = true;
    });
    try {
      tenderList = await TenderService().fetchTenders();
      print(tenderList);
    } catch (e) {
      // Handle errors here
      print('Error fetching tenders: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Method to refresh tenders
  Future<void> _refreshTenders() async {
    await _fetchTenders(); // Call the fetch method to reload data
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Tenders",
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : tenderList != null
              ? RefreshIndicator(
                  onRefresh: _refreshTenders, // Add refresh function
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: tenderList!.length,
                      itemBuilder: (context, index) {
                        final tender = tenderList![index];
                        return TenderTile(
                          tender: tender,
                          onTap: () {
                            // Navigate to TenderDetailScreen when a tender is clicked
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TenderDetailScreen(
                                        tender: tender,
                                      )),
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              : Center(child: Text('No tenders available')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Tender Creation screen when button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTenderScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Тендер үүсгэх',
      ),
    );
  }
}
