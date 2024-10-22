import 'package:erp_1/models/Models.dart'; // Adjust the path to your Job model
import 'package:erp_1/utils/api.dart'; // Adjust the path to your ApiUtils
import 'package:erp_1/utils/storage.dart'; // Adjust the path to your StorageUtils

class JobService {
  // Fetch all jobs
  Future<List<Job>> fetchJobs() async {
    try {
      // Get the authentication token
      String? token = await StorageUtils.getToken();

      // Call the API to get jobs
      final response = await ApiUtils.get('jobs/', token: token);
      print('Raw response: $response'); // Print raw response

      // Check if the response is actually a list
      if (response is! List<dynamic>) {
        throw Exception('Unexpected response format: $response');
      }

      // Parse the response into a list of Job objects
      List<dynamic> jobsJson = response;
      return jobsJson.map((json) => Job.fromJson(json)).toList();
    } catch (error) {
      print('Error in fetchJobs: $error');
      throw error;
    }
  }

  // Create a new job
  Future<Job?> createJob(Map<String, dynamic> jobData) async {
    try {
      // Get the authentication token
      String? token = await StorageUtils.getToken();

      // Call the API to create a job
      final response = await ApiUtils.post('jobs/', jobData, token: token);

      // Check if there was an error in the response
      if (response['error'] != null) {
        throw Exception('Error creating job: ${response['error']}');
      }

      // Parse and return the created Job object
      return Job.fromJson(response);
    } catch (error) {
      print('Error in createJob: $error');
      throw error;
    }
  }

  // Fetch a single job by ID (optional if needed)
  Future<Job?> getJobById(String jobId) async {
    try {
      String? token = await StorageUtils.getToken();
      final response = await ApiUtils.get('jobs/$jobId/', token: token);

      if (response['error'] != null) {
        throw Exception('Error fetching job: ${response['error']}');
      }

      return Job.fromJson(response);
    } catch (error) {
      print('Error in getJobById: $error');
      throw error;
    }
  }

  // Update a job (optional if needed)
  Future<Job?> updateJob(String jobId, Map<String, dynamic> jobData) async {
    try {
      String? token = await StorageUtils.getToken();
      final response =
          await ApiUtils.put('jobs/$jobId/', jobData, token: token);

      if (response['error'] != null) {
        throw Exception('Error updating job: ${response['error']}');
      }

      return Job.fromJson(response);
    } catch (error) {
      print('Error in updateJob: $error');
      throw error;
    }
  }

  // Delete a job (optional if needed)
  Future<void> deleteJob(String jobId) async {
    try {
      String? token = await StorageUtils.getToken();
      final response = await ApiUtils.delete('jobs/$jobId/', token: token);

      if (response['error'] != null) {
        throw Exception('Error deleting job: ${response['error']}');
      }
    } catch (error) {
      print('Error in deleteJob: $error');
      throw error;
    }
  }
}
