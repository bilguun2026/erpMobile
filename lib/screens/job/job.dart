import 'package:flutter/material.dart';
import 'package:erp_1/models/Models.dart'; // Adjust the path
import 'package:erp_1/utils/jobService.dart'; // Adjust the path
import 'package:erp_1/widgets/job_tile.dart'; // Adjust the path
import 'package:erp_1/widgets/appBar.dart'; // CustomScaffold
import 'package:erp_1/screens/job/createJob.dart'; // Create Job Screen
import 'package:erp_1/screens/job/jobDetail.dart'; // Job Detail Screen

class JobScreen extends StatefulWidget {
  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  List<Job>? jobList;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchJobs();
  }

  // Method to fetch jobs
  Future<void> _fetchJobs() async {
    setState(() {
      _isLoading = true;
    });
    try {
      jobList = await JobService().fetchJobs();
      print(jobList);
    } catch (e, stackTrace) {
      print('Error fetching jobs: $e');
      print('Stack trace: $stackTrace');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Method to refresh jobs
  Future<void> _refreshJobs() async {
    await _fetchJobs();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: "Jobs",
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : jobList != null
              ? RefreshIndicator(
                  onRefresh: _refreshJobs,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: jobList!.length,
                      itemBuilder: (context, index) {
                        final job = jobList![index];
                        return JobTile(
                          job: job,
                          onTap: () {
                            // Navigate to JobDetailScreen when a job is clicked
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JobDetailScreen(
                                        job: job,
                                      )),
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              : Center(child: Text('No jobs available')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to Create Job Screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateJobScreen()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Create Job',
      ),
    );
  }
}
