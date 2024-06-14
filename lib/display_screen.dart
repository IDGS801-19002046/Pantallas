import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_screen.dart';
import 'registration_screen.dart';

class DisplayScreen extends StatelessWidget {
  Future<String?> _getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  void _deleteName(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegistrationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombre Guardado'),
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: FutureBuilder<String?>(
        future: _getName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final name = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name ?? '',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditScreen()),
                          );
                        },
                        icon: Icon(Icons.edit),
                        label: Text('Editar Nombre'),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => _deleteName(context),
                        icon: Icon(Icons.delete),
                        label: Text('Eliminar Nombre'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
