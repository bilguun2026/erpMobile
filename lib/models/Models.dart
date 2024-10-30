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
  final String? job;
  final String? vehicle;
  final int? driver;
  final int? user;
  final String? pointANote;
  final String? pointBNote;
  final String? generalSupervisorNote;

  Transport({
    this.id,
    this.remainingJobQuantity,
    this.percentage,
    this.startDate,
    this.endDate,
    this.transportWeight,
    this.status,
    this.job,
    this.vehicle,
    this.driver,
    this.user,
    this.pointANote,
    this.pointBNote,
    this.generalSupervisorNote,
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
      job: json['job'] as String?,
      vehicle: json['vehicle'] as String?,
      driver: json['driver'] as int?,
      user: json['user'] as int?,
      pointANote: json['point_a_note'] as String?,
      pointBNote: json['point_b_note'] as String?,
      generalSupervisorNote: json['general_supervisor_note'] as String?,
    );
  }
}

class Salary {
  final String id;
  final String user;
  final double baseSalary;
  final double bonus;
  final double travelAllowance;
  final double foodAllowance;
  final double housingAllowance;
  final double deductions;
  final double tax;
  final int overtimeHours;
  final double overtimeRate;
  final double totalSalary;
  final String salaryDate;

  Salary({
    required this.id,
    required this.user,
    required this.baseSalary,
    required this.bonus,
    required this.travelAllowance,
    required this.foodAllowance,
    required this.housingAllowance,
    required this.deductions,
    required this.tax,
    required this.overtimeHours,
    required this.overtimeRate,
    required this.totalSalary,
    required this.salaryDate,
  });

  factory Salary.fromJson(Map<String, dynamic> json) {
    double _parseDouble(dynamic value) {
      if (value is String) {
        return double.tryParse(value) ?? 0.0; // Convert from String to double
      } else if (value is num) {
        return value.toDouble(); // Convert num (int or double) to double
      } else {
        return 0.0; // Default to 0.0 if the value is neither a String nor num
      }
    }

    int _parseInt(dynamic value) {
      if (value is String) {
        return int.tryParse(value) ?? 0; // Convert from String to int
      } else if (value is int) {
        return value; // Use int directly
      } else {
        return 0; // Default to 0 if the value is neither a String nor int
      }
    }

    return Salary(
      id: json['id'].toString(),
      user: json['user'].toString(),
      baseSalary: _parseDouble(json['base_salary']),
      bonus: _parseDouble(json['bonus']),
      travelAllowance: _parseDouble(json['travel_allowance']),
      foodAllowance: _parseDouble(json['food_allowance']),
      housingAllowance: _parseDouble(json['housing_allowance']),
      deductions: _parseDouble(json['deductions']),
      tax: _parseDouble(json['tax']),
      overtimeHours: _parseInt(json['overtime_hours']),
      overtimeRate: _parseDouble(json['overtime_rate']),
      totalSalary: _parseDouble(json['total_salary']),
      salaryDate: json['salary_date'].toString(),
    );
  }
}

class Payroll {
  final String id;
  final String user;
  final String month;
  final double? totalSalary;
  final String status;
  final String? paidOn;

  Payroll({
    required this.id,
    required this.user,
    required this.month,
    this.totalSalary,
    required this.status,
    this.paidOn,
  });

  factory Payroll.fromJson(Map<String, dynamic> json) {
    return Payroll(
      id: json['id'],
      user: json['user'],
      month: json['month'],
      totalSalary: json['total_salary'],
      status: json['status'],
      paidOn: json['paid_on'],
    );
  }
}
