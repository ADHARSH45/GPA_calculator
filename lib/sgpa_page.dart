import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SGPAInputPage extends StatefulWidget {
  final String department;
  final int semester;

  SGPAInputPage({required this.department, required this.semester});

  @override
  _SGPAInputPageState createState() => _SGPAInputPageState();
}

class _SGPAInputPageState extends State<SGPAInputPage> {
  List<Map<String, dynamic>> subjects = [];
  Map<String, double> gradePoints = {
    "S": 10.0,
    "A+": 9.0,
    "A": 8.5,
    "B+": 8.0,
    "B": 7.5,
    "C+": 7.0,
    "C": 6.5,
    "D": 6.0,
    "P": 5.5,
    "F": 0.0
  };
  Map<String, String> selectedGrades = {};
  bool subjectsLoaded = false;

  @override
  void initState() {
    super.initState();
    loadSubjects();
  }

  Future<void> loadSubjects() async {
    String data = await rootBundle.loadString('assets/subjects.json');
    Map<String, dynamic> jsonData = json.decode(data);

    setState(() {
      subjects = List<Map<String, dynamic>>.from(
          jsonData[widget.department]?[widget.semester.toString()] ?? []);
      subjectsLoaded = true;
    });
  }

  void _calculateSGPA() {
    double totalCredits = 0, weightedSum = 0;

    subjects.forEach((subject) {
      String name = subject["name"];
      int credits = subject["credits"];
      if (selectedGrades.containsKey(name)) {
        weightedSum += (gradePoints[selectedGrades[name]]! * credits);
        totalCredits += credits;
      }
    });

    double sgpa = (totalCredits == 0) ? 0 : weightedSum / totalCredits;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white.withOpacity(0.9),
        title: Center(
          child: Text("SGPA Result",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
        content: Text(
          "Your SGPA is: ${sgpa.toStringAsFixed(2)}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text("OK", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SGPA Input")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.deepPurpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: subjectsLoaded
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: subjects.length,
                        itemBuilder: (context, index) {
                          String subjectName = subjects[index]["name"];
                          int credits = subjects[index]["credits"];

                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.3)),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        subjectName,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide.none),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 15),
                                        ),
                                        hint: Text("Select Grade"),
                                        value: selectedGrades[subjectName],
                                        onChanged: (value) {
                                          setState(() {
                                            selectedGrades[subjectName] =
                                                value!;
                                          });
                                        },
                                        items: gradePoints.keys.map((grade) {
                                          return DropdownMenuItem(
                                            value: grade,
                                            child: Text(grade),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      onPressed: _calculateSGPA,
                      child: Text("Calculate SGPA",
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
