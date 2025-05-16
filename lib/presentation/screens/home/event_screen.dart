import 'package:flutter/material.dart';
import 'package:medihub_app/models/event.dart';
import 'package:medihub_app/presentation/screens/home/event_detail.dart';
import 'package:medihub_app/presentation/screens/home/home.dart';
import 'package:medihub_app/presentation/screens/home/navigation.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildEventItem(EventModel event) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // Navigate to event details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsScreen(event: event),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  event.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.event, color: Colors.blue),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      event.description,
                      style: TextStyle(color: Colors.grey[700]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(ActivityModel activity) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // Navigate to activity details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActivityDetailsScreen(activity: activity),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blue[700], size: 16),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      activity.location,
                      style: TextStyle(color: Colors.grey[700]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.blue[700], size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '${activity.dateTime.day}/${activity.dateTime.month}/${activity.dateTime.year}',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_backspace, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavigationBottom()),
            );
          },
        ),
        title: Text(
          "Sự kiện & Hoạt động",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(fontSize: 16, fontFamily: 'Calistoga'),
          tabs: const [Tab(text: 'Sự kiện'), Tab(text: 'Hoạt động')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Events Tab
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: DataEvent.getEvents().length,
              itemBuilder: (context, index) {
                return _buildEventItem(DataEvent.getEvents()[index]);
              },
            ),
          ),

          // Activities Tab
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemCount: DataEvent.getActivities().length,
              itemBuilder: (context, index) {
                return _buildActivityItem(DataEvent.getActivities()[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
