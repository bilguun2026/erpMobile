class Tender {
  final String? id;
  final String? name;
  final String? description;
  final int? totalCoalQuantity;
  final String? origin;
  final String? destination;
  final String? deadline;
  final String? status;
  final int? totalJobCoalQuantity;
  final int? percentage;
  final List<Job>? jobs;

  Tender({
    this.id,
    this.name,
    this.description,
    this.totalCoalQuantity,
    this.origin,
    this.destination,
    this.deadline,
    this.status,
    this.totalJobCoalQuantity,
    this.percentage,
    this.jobs,
  });

  factory Tender.fromJson(Map<String, dynamic> json) {
    var jobsList = json['jobs'] as List<dynamic>?;
    return Tender(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      totalCoalQuantity: json['total_coal_quantity'] is double
          ? (json['total_coal_quantity'] as double).toInt()
          : json['total_coal_quantity'] as int?,
      origin: json['origin'] as String?,
      destination: json['destination'] as String?,
      deadline: json['deadline'] as String?,
      status: json['status'] as String?,
      totalJobCoalQuantity: json['total_job_coal_quantity'] is double
          ? (json['total_job_coal_quantity'] as double).toInt()
          : json['total_job_coal_quantity'] as int?,
      percentage: json['percentage'] is double
          ? (json['percentage'] as double).toInt()
          : json['percentage'] as int?,
      jobs: jobsList != null
          ? jobsList.map((job) => Job.fromJson(job)).toList()
          : [],
    );
  }
}

class Job {
  final String? id;
  final int? remainingCoalQuantity;
  final int? percentage;
  final String? origin;
  final String? destination;
  final String? startDate;
  final String? endDate;
  final String? jobStatus;
  final int? jobCoalQuantity;
  final List<Transport>? transports;

  Job({
    this.id,
    this.remainingCoalQuantity,
    this.percentage,
    this.origin,
    this.destination,
    this.startDate,
    this.endDate,
    this.jobStatus,
    this.jobCoalQuantity,
    this.transports,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    var transportList = json['transports'] as List<dynamic>?;

    return Job(
      id: json['id'] as String?,
      remainingCoalQuantity: (json['remaining_coal_quantity'] is double)
          ? (json['remaining_coal_quantity'] as double).toInt()
          : json['remaining_coal_quantity']
              as int?, // Handle double to int conversion
      percentage: (json['percentage'] is double)
          ? (json['percentage'] as double).toInt()
          : json['percentage'] as int?,
      origin: json['origin'] as String?,
      destination: json['destination'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      jobStatus: json['job_status'] as String?,
      jobCoalQuantity: (json['job_coal_quantity'] is double)
          ? (json['job_coal_quantity'] as double).toInt()
          : json['job_coal_quantity']
              as int?, // Handle double to int conversion
      transports: transportList != null
          ? transportList
              .map((transport) => Transport.fromJson(transport))
              .toList()
          : [],
    );
  }
}

class Transport {
  final String? id;
  final int? remainingJobQuantity;
  final int? percentage;
  final String? startDate;
  final String? endDate;
  final int? transportWeight;
  final String? status;

  Transport({
    this.id,
    this.remainingJobQuantity,
    this.percentage,
    this.startDate,
    this.endDate,
    this.transportWeight,
    this.status,
  });

  factory Transport.fromJson(Map<String, dynamic> json) {
    return Transport(
      id: json['id'] as String?,
      remainingJobQuantity: (json['remaining_job_quantity'] is double)
          ? (json['remaining_job_quantity'] as double).toInt()
          : json['remaining_job_quantity']
              as int?, // Handle double to int conversion
      percentage: (json['percentage'] is double)
          ? (json['percentage'] as double).toInt()
          : json['percentage'] as int?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      transportWeight: (json['transport_weight'] is double)
          ? (json['transport_weight'] as double).toInt()
          : json['transport_weight'] as int?, // Handle double to int conversion
      status: json['status'] as String?,
    );
  }
}
