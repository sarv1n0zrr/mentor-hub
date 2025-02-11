import 'package:flutter/material.dart';

class MentorsPage extends StatefulWidget {
  const MentorsPage({super.key, required this.searchController});
  final SearchController searchController;

  @override
  State<MentorsPage> createState() => _MentorsPageState();
}

class _MentorsPageState extends State<MentorsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchResults = [];
  bool isSearching = false;
  String _selected = "Courses";

  Widget _getSelectedPage() {
    switch (_selected) {
      case "Courses":
        return SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: Text(
                            "Subject",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(
                          "Location",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(
                          "Price",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(
                          "Duration",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.black)),
                      child: Center(
                        child: Text(
                          "Popular",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: Center(
                            child: Text(
                              'POSTER',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Course Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'description text...',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$17.50',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star_half,
                                        color: Colors.amber, size: 16),
                                    SizedBox(width: 5),
                                    Text('4.5'),
                                  ],
                                ),
                                Icon(Icons.favorite_border, color: Colors.red),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: Center(
                            child: Text(
                              'POSTER',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Course Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'description text...',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$17.50',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star_half,
                                        color: Colors.amber, size: 16),
                                    SizedBox(width: 5),
                                    Text('4.5'),
                                  ],
                                ),
                                Icon(Icons.favorite_border, color: Colors.red),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: Center(
                            child: Text(
                              'POSTER',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Course Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'description text...',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$17.50',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star_half,
                                        color: Colors.amber, size: 16),
                                    SizedBox(width: 5),
                                    Text('4.5'),
                                  ],
                                ),
                                Icon(Icons.favorite_border, color: Colors.red),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: Center(
                            child: Text(
                              'POSTER',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Course Name',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'description text...',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$17.50',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star,
                                        color: Colors.amber, size: 16),
                                    Icon(Icons.star_half,
                                        color: Colors.amber, size: 16),
                                    SizedBox(width: 5),
                                    Text('4.5'),
                                  ],
                                ),
                                Icon(Icons.favorite_border, color: Colors.red),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
        );
      case "Mentors":
        return SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Container(
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(color: Colors.black)),
                              child: Center(
                                child: Text(
                                  "Subject",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: Colors.black)),
                            child: Center(
                              child: Text(
                                "Subject",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: Colors.black)),
                            child: Center(
                              child: Text(
                                "Subject",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: 80,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: Colors.black)),
                            child: Center(
                              child: Text(
                                "Subject",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    SizedBox(
                      height: 150,
                      width: 100,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey[300],
                                child: Icon(
                                  Icons.person,
                                  size: 20,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Alisher Zhunisov',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Python Teacher',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  SizedBox(width: 4),
                                  Text('5.0'),
                                ],
                              ),
                              SizedBox(height: 2),
                              Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 150,
                      width: 100,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey[300],
                                child: Icon(
                                  Icons.person,
                                  size: 20,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Alisher Zhunisov',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Python Teacher',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  SizedBox(width: 4),
                                  Text('5.0'),
                                ],
                              ),
                              SizedBox(height: 2),
                              Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 150,
                      width: 100,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey[300],
                                child: Icon(
                                  Icons.person,
                                  size: 20,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Alisher Zhunisov',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Python Teacher',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 8),
                                  SizedBox(width: 4),
                                  Text('5.0'),
                                ],
                              ),
                              SizedBox(height: 2),
                              Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      default:
        return Container();
    }
  }

  void _onSearch() {
    setState(() {
      isSearching = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black)),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: IconButton(
                        onPressed: _onSearch,
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        )),
                    contentPadding: EdgeInsets.symmetric(vertical: 15)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton(
                  segments: <ButtonSegment<String>>[
                    ButtonSegment<String>(
                        value: "Courses", label: Text("Courses")),
                    ButtonSegment<String>(
                        value: "Mentors", label: Text("Mentors"))
                  ],
                  selected: {
                    _selected
                  },
                  onSelectionChanged: (newSelection) {
                    setState(() {
                      _selected = newSelection.first;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.white; // Цвет активной кнопки
                      }
                      return Colors.transparent; // Цвет неактивной кнопки
                    }),
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      if (states.contains(WidgetState.selected)) {
                        return Colors.black; // Цвет текста активной кнопки
                      }
                      return Colors.black54; // Цвет текста неактивной кнопки
                    }),
                    side: WidgetStateProperty.all(
                      BorderSide(
                          color: Colors.black, width: 2), // Граница кнопок
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), //  скругление
                      ),
                    ),
                  )),
            ),
          ),
          Expanded(
            child: _getSelectedPage(),
          ),
        ],
      ),
    );
  }
}
