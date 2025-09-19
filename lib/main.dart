import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(EduApp());
}

class EduApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Education App UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: RootScreen(),
      routes: {
        '/courses': (_) => CoursesScreen(),
        '/player': (_) => PlayerScreen(),
        '/calendar': (_) => CalendarScreen(),
        '/stats': (_) => StatsScreen(),
        '/profile': (_) => ProfileScreen(),
        '/settings': (_) => SettingsScreen(),
      },
    );
  }
}

/// Reusable gradient container to mimic the designs
class GradientScaffold extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final bool showTopPadding;

  GradientScaffold({
    required this.child,
    this.colors = const [Color(0xFF4B6CB7), Color(0xFF182848)],
    this.showTopPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors, begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: SafeArea(
        top: showTopPadding,
        child: child,
      ),
    );
  }
}

/// Root with Bottom Navigation
class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    CoursesScreen(),
    PlayerScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.play_circle_outline), label: 'Player'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

/// Home Screen (intro / dashboard)
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      colors: [Color(0xFF3A7BD5), Color(0xFF00d2ff)],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(Icons.school_outlined, color: Colors.white, size: 36),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('EDUCATION', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    Text('Mobile APP', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Spacer(),
                CircleAvatar(child: Icon(Icons.person), backgroundColor: Colors.white24),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Quick cards grid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _statCard('Lessons', '25', Icons.auto_stories_outlined),
                        _statCard('Progress', '56%', Icons.show_chart),
                        _statCard('Courses', '6', Icons.grid_view),
                      ],
                    ),
                    SizedBox(height: 18),

                    // Courses preview list
                    _sectionTitle('Courses'),
                    CourseTile(
                      title: 'Intro to Physics',
                      subtitle: '12 lessons · 3h',
                      progress: 0.3,
                    ),
                    CourseTile(
                      title: 'Web Development',
                      subtitle: '10 lessons · 2.5h',
                      progress: 0.7,
                    ),
                    CourseTile(
                      title: 'Data Science Basics',
                      subtitle: '8 lessons · 2h',
                      progress: 0.15,
                    ),

                    SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/courses'),
                      child: Text('View All Courses'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      ),
                    ),
                    SizedBox(height: 18),

                    // Activity / upcoming
                    _sectionTitle('Upcoming'),
                    ListTile(
                      leading: CircleAvatar(child: Icon(Icons.calendar_today_outlined)),
                      title: Text('Live Session: Modern Physics'),
                      subtitle: Text('27 Sep • 6:30 PM'),
                      trailing: Icon(Icons.chevron_right),
                    ),
                    ListTile(
                      leading: CircleAvatar(child: Icon(Icons.schedule)),
                      title: Text('Assignment 3 due'),
                      subtitle: Text('30 Sep • 11:59 PM'),
                      trailing: Icon(Icons.chevron_right),
                    ),

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFF6F9FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: Colors.indigo),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 4),
            Text(label, style: TextStyle(color: Colors.black54, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String t) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(t, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}

/// Simple course tile widget used on many screens
class CourseTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;

  CourseTile({required this.title, required this.subtitle, this.progress = 0.0});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, '/player'),
        leading: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF667EEA), Color(0xFF764BA2)]),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(Icons.auto_stories, color: Colors.white),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle),
            SizedBox(height: 6),
            LinearProgressIndicator(value: progress),
          ],
        ),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}

/// Courses screen (list of courses, categories)
class CoursesScreen extends StatelessWidget {
  final List<Map<String, dynamic>> courses = [
    {'title': 'Intro to Physics', 'lessons': 12, 'time': '3h'},
    {'title': 'Web Development', 'lessons': 10, 'time': '2.5h'},
    {'title': 'Data Science Basics', 'lessons': 8, 'time': '2h'},
    {'title': 'UI/UX Fundamentals', 'lessons': 6, 'time': '1.5h'},
  ];

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      colors: [Color(0xFFffffff), Color(0xFFF7F9FF)],
      showTopPadding: false,
      child: SafeArea(
        child: Column(
          children: [
            _topBar(context, 'Courses'),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: courses.length,
                itemBuilder: (context, i) {
                  final c = courses[i];
                  return CourseTile(
                    title: c['title'],
                    subtitle: '${c['lessons']} lessons · ${c['time']}',
                    progress: (i + 1) / 4.0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topBar(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 18, 16, 8),
      child: Row(
        children: [
          IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back)),
          SizedBox(width: 6),
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Spacer(),
          Icon(Icons.search),
          SizedBox(width: 12),
          CircleAvatar(child: Icon(Icons.person)),
        ],
      ),
    );
  }
}

/// Player screen (video/audio player mock)
class PlayerScreen extends StatelessWidget {
  final List<String> lessons = ['01. Intro', '02. Basics', '03. Theory', '04. Examples', '05. Quiz'];

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      colors: [Color(0xFF3A7BD5), Color(0xFF00d2ff)],
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back, color: Colors.white)),
                Spacer(),
                Text('Course Player', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                Spacer(),
                Icon(Icons.more_vert, color: Colors.white),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
              child: Column(
                children: [
                  // big player card
                  Container(
                    height: 170,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF667EEA), Color(0xFF764BA2)]),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Icon(Icons.play_circle_fill, size: 56, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      itemCount: lessons.length,
                      separatorBuilder: (_, __) => Divider(),
                      itemBuilder: (context, i) {
                        return ListTile(
                          leading: CircleAvatar(backgroundColor: Colors.deepOrange.shade50, child: Text('${i+1}')),
                          title: Text(lessons[i]),
                          subtitle: Text('20 min'),
                          trailing: Icon(Icons.download_outlined),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Calendar screen (simple calendar-like UI)
class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back, color: Colors.white)),
                SizedBox(width: 6),
                Text('March', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                Spacer(),
                Icon(Icons.calendar_today, color: Colors.white),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
              child: Column(
                children: [
                  _calendarRow(),
                  SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(leading: Icon(Icons.event), title: Text('Live: Modern Physics'), subtitle: Text('27 Mar • 6:30 PM')),
                        ListTile(leading: Icon(Icons.event_note), title: Text('Quiz: Module 2'), subtitle: Text('28 Mar • 2:00 PM')),
                        ListTile(leading: Icon(Icons.assignment), title: Text('Assignment due'), subtitle: Text('30 Mar • 11:59 PM')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _calendarRow() {
    final days = ['Su','Mo','Tu','We','Th','Fr','Sa'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((d) => Expanded(child: Center(child: Text(d, style: TextStyle(fontWeight: FontWeight.bold))))).toList(),
    );
  }
}

/// Stats / analytics screen
class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      colors: [Color(0xFFffffff), Color(0xFFf3f7ff)],
      showTopPadding: false,
      child: SafeArea(
        child: Column(
          children: [
            topBar(context, 'Analytics'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    // simple bar-like representation
                    Row(
                      children: [
                        Expanded(child: _statBox('30%', 'Completed')),
                        SizedBox(width: 12),
                        Expanded(child: _statBox('70%', 'Remaining')),
                      ],
                    ),
                    SizedBox(height: 18),
                    _miniBar('Mon', 0.4),
                    _miniBar('Tue', 0.6),
                    _miniBar('Wed', 0.8),
                    _miniBar('Thu', 0.5),
                    _miniBar('Fri', 0.7),
                    SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/settings'),
                      child: Text('Settings'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget topBar(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        children: [
          IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back)),
          SizedBox(width: 6),
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Spacer(),
          Icon(Icons.share),
        ],
      ),
    );
  }

  Widget _statBox(String value, String label) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _miniBar(String day, double v) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(width: 50, child: Text(day)),
          Expanded(
            child: LinearProgressIndicator(value: v, minHeight: 12),
          ),
          SizedBox(width: 10),
          Text('${(v*100).round()}%'),
        ],
      ),
    );
  }
}

/// Profile screen
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      colors: [Color(0xFF4B6CB7), Color(0xFF182848)],
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: Row(
              children: [
                CircleAvatar(radius: 28, child: Icon(Icons.person, size: 28)),
                SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Lorem Name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  Text('Student', style: TextStyle(color: Colors.white70)),
                ]),
                Spacer(),
                Icon(Icons.settings, color: Colors.white),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
              child: ListView(
                children: [
                  ListTile(leading: Icon(Icons.school), title: Text('My Courses')),
                  ListTile(leading: Icon(Icons.payment), title: Text('Payments')),
                  ListTile(leading: Icon(Icons.history), title: Text('Activity')),
                  ListTile(leading: Icon(Icons.logout), title: Text('Log out')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Settings screen (simple)
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(title: Text('Notifications'), value: true, onChanged: (v) {}),
          ListTile(title: Text('Language'), subtitle: Text('English')),
          ListTile(title: Text('Help & Support')),
        ],
      ),
    );
  }
}
