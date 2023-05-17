import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<dynamic, dynamic>? data;

  @override
  Widget build(BuildContext context) {
    // Make the access to isNotEmpty conditional using the `?` operator
    data = data?.isNotEmpty == true
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>?;

    // Alternatively, add a null check using the `!` operator
    // data = data!.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>?;

    // Add a null check here
    if (data == null) {
      data = {};
    }

    print(data);

    // Set background
    String bgImage = data!['isDayTime'] ? 'day1.jpg' : 'night1.jpg';
    Color bgColor =
        data!['isDayTime'] ? Colors.blue[300]! : Colors.indigo[700]!;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 200.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDayTime': result['isDayTime'],
                        'flag': result['flag'],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.brown,
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.brown[400],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data!['location'],
                      style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  data!['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
