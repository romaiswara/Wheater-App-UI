import 'package:flutter/material.dart';
import 'package:flutter_ui_challenge_weather/color.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int currentTab;

  List<TabData> tabs = [
    TabData(
      time: '6:00 am',
      background: 'assets/images/1.png',
      icon: 'assets/images/cloud.png',
      description: 'Sunrise',
      color: morningColor,
    ),
    TabData(
      time: '12:00 pm',
      background: 'assets/images/2.png',
      icon: 'assets/images/sun.png',
      description: 'Clear Sky',
      color: afternoonColor,
    ),
    TabData(
      time: '6:30 pm',
      background: 'assets/images/3.png',
      icon: 'assets/images/cloud.png',
      description: 'Clear Sky',
      color: eveningColor,
    ),
    TabData(
      time: '11:00 pm',
      background: 'assets/images/4.png',
      icon: 'assets/images/moon.png',
      description: 'Clear Sky',
      color: nightColor,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    currentTab = 0;
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // BACKGROUND
          Image.asset(
            tabs[currentTab].background,
            width: s.width,
          ),

          Container(
            margin: EdgeInsets.only(top: s.width),
            padding: EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),

                // TODAY
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today, March 8th',
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.menu_rounded),
                    ],
                  ),
                ),

                SizedBox(height: 4),

                // LOCATION
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: greyColor,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Bloamington, In',
                        style: TextStyle(
                          color: greyColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                // DIVIDER
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Divider(),
                ),

                // TAB
                TabBar(
                  controller: _tabController,
                  labelColor: tabs[currentTab].color,
                  unselectedLabelColor: greyColor,
                  tabs: List.generate(
                    tabs.length,
                    (index) => tabWidget(
                      tab: tabs[index],
                      selected: index == currentTab,
                    ),
                  ),
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: tabs[currentTab].color,
                      ),
                    ),
                  ),
                  onTap: (val) {
                    currentTab = val;
                    setState(() {});
                  },
                ),

                // INFO
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/cloud.png',
                                height: 60,
                                color: greyDarkColor,
                              ),
                              SizedBox(height: 4),
                              Text(
                                '21 C',
                                style: TextStyle(
                                  color: greyDarkColor,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                'Cloud Sky, Feels like rain.',
                                style: TextStyle(
                                  color: greyDarkColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('More Details'),
                                style: ElevatedButton.styleFrom(
                                    primary: tabs[currentTab].color,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              percentWidget(
                                percent: '25%',
                                description: 'Humidity',
                              ),
                              SizedBox(height: 16),
                              percentWidget(
                                percent: '60%',
                                description: 'Chance of Rain',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tabWidget({TabData tab, bool selected}) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Text(
            tabs[currentTab].time,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4),
          Image.asset(
            tab.icon,
            color: (selected) ? tab.color : greyColor,
            height: 18,
          ),
          SizedBox(height: 4),
          Text(
            tab.description,
            style: TextStyle(
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget percentWidget({String percent, String description}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            tabs[currentTab].color.withOpacity(0.25),
            tabs[currentTab].color.withOpacity(0.01),
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(0.0, 1.0),
        ),
      ),
      child: Column(
        children: [
          Text(
            percent,
            style: TextStyle(
              color: tabs[currentTab].color,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            description,
            style: TextStyle(
              color: tabs[currentTab].color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class TabData {
  final String time;
  final String background;
  final String icon;
  final String description;
  final Color color;

  TabData({
    this.time,
    this.background,
    this.icon,
    this.description,
    this.color,
  });
}
