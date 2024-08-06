import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  final List<Technician> technicians = [
    Technician(
      imagePath: 'assets/images/M1.png',
      name: 'Johan',
      lastName: 'Guzmán',
      id: '2022-0520',
    ),
    Technician(
      imagePath: 'assets/images/M2.png',
      name: 'Berlyn',
      lastName: 'Sánchez González',
      id: '2022-0660',
    ),
    Technician(
      imagePath: 'assets/images/M3.png',
      name: 'German Junior',
      lastName: 'Cespedes Estevez',
      id: '2019-7569',
    ),
    Technician(
      imagePath: 'assets/images/M4.png',
      name: 'Saulo Enrique',
      lastName: 'Zabala Garcia',
      id: '2022-0131',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Más Información'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información del Técnico',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: technicians.length,
                itemBuilder: (context, index) {
                  final technician = technicians[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(technician.imagePath),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${technician.name} ${technician.lastName}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Matrícula: ${technician.id}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Reflexión',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '"La educación es el arma más poderosa que puedes usar para cambiar el mundo." - Nelson Mandela',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Technician {
  final String imagePath;
  final String name;
  final String lastName;
  final String id;

  Technician({
    required this.imagePath,
    required this.name,
    required this.lastName,
    required this.id,
  });
}
