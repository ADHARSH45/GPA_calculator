import 'package:flutter/material.dart';
import 'package:gpacalculator/sgpa_page.dart';

class SGPASelectionPage extends StatefulWidget {
  @override
  _SGPASelectionPageState createState() => _SGPASelectionPageState();
}

class _SGPASelectionPageState extends State<SGPASelectionPage> {
  String? selectedDepartment;
  int? selectedSemester;

  final List<String> departments = [
    "Computer Science",
    "Civil Engineering",
    "Mechanical Engineering",
    "Electronics and Communication",
    "Electrical and Electronics",
  ];
  final List<int> semesters = [1, 2, 3, 4, 5, 6, 7, 8];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.deepPurpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Select Department & Semester",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 20),

              // Department Selection
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    Text("Select Department",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: departments.map((dept) {
                        bool isSelected = selectedDepartment == dept;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDepartment = dept;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                          color: Colors.white38, blurRadius: 5)
                                    ]
                                  : [],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.school,
                                    color: isSelected
                                        ? Colors.blueAccent
                                        : Colors.white),
                                SizedBox(width: 10),
                                Text(dept,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: isSelected
                                            ? Colors.blueAccent
                                            : Colors.white)),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(height: 30),

                    // Semester Selection
                    Text("Select Semester",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: semesters.map((sem) {
                        bool isSelected = selectedSemester == sem;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSemester = sem;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                          color: Colors.white38, blurRadius: 5)
                                    ]
                                  : [],
                            ),
                            child: Text(
                              "Semester $sem",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.blueAccent
                                      : Colors.white),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              // Next Button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed:
                      selectedDepartment != null && selectedSemester != null
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SGPAInputPage(
                                    department: selectedDepartment!,
                                    semester: selectedSemester!,
                                  ),
                                ),
                              );
                            }
                          : null,
                  child: Text(
                    "Next",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
