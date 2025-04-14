import 'package:flutter/material.dart';

class NewsSection extends StatefulWidget {
  const NewsSection({Key? key}) : super(key: key);

  @override
  State<NewsSection> createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  // Dữ liệu tin tức được chuyển thành static để tránh tạo lại mỗi khi widget được rebuild
  static final List<NewsItem> _allNewsItems = [
    NewsItem(
      title: 'TRIỆU CHỨNG CÚM A Ở NGƯỜI LỚN VÀ DẤU HIỆU NGUY HIỂM CẦN ĐẾN NGAY BÁC SĨ',
      imageUrl: 'assets/images/news1.jpg',
      date: '03/02/2023',
      time: '13:45',
      tags: ['Bệnh truyền nhiễm'],
      category: 'Bệnh truyền nhiễm',
    ),
    NewsItem(
      title: 'CÚM A CÓ LÂY KHÔNG? LÂY QUA ĐƯỜNG NÀO PHỔ BIẾN?',
      imageUrl: 'assets/images/news2.jpg',
      date: '03/02/2023',
      time: '15:56',
      tags: const [],
      category: 'Bệnh truyền nhiễm',
    ),
    NewsItem(
      title: 'XÉT NGHIỆM CÚM A BẰNG CÁCH NÀO? QUY TRÌNH TEST CÚM A, B RA SAO?',
      imageUrl: 'assets/images/news3.jpg',
      date: '03/02/2023',
      time: '16:03',
      tags: const [],
      category: 'Bệnh truyền nhiễm',
    ),
    NewsItem(
      title: 'NGƯỜI LỚN BỊ CÚM A BAO LÂU THÌ KHỎI? LÀM GÌ ĐỂ NHANH HỒI BỆNH?',
      imageUrl: 'assets/images/news4.jpg',
      date: '03/02/2023',
      time: '16:07',
      tags: const [],
      category: 'Lịch tiêm chủng',
    ),
    NewsItem(
      title: 'BỊ CẢM CÚM A NÊN KIÊNG GÌ NHANH KHỎI? 6 LOẠI THỰC PHẨM TRỊ CÚM HIỆU QUẢ',
      imageUrl: 'assets/images/news5.jpg',
      date: '03/02/2023',
      time: '',
      tags: const [],
      category: 'Lịch tiêm chủng',
    ),
    // Thêm tin tức mẫu cho các danh mục khác
    NewsItem(
      title: 'HƯỚNG DẪN KHÁM SỨC KHỎE ĐỊNH KỲ CHO NGƯỜI TRÊN 40 TUỔI',
      imageUrl: 'assets/images/news6.jpg',
      date: '04/02/2023',
      time: '09:30',
      tags: const [],
      category: 'Thông tin ưu đãi',
    ),
    NewsItem(
      title: 'CÁC XÉT NGHIỆM CẦN THIẾT TRONG KỲ KHÁM SỨC KHỎE TỔNG QUÁT',
      imageUrl: 'assets/images/news7.jpg',
      date: '04/02/2023',
      time: '10:15',
      tags: const [],
      category: 'Thông tin ưu đãi',
    ),
    NewsItem(
      title: 'TRIỆU CHỨNG VIÊM HỌNG CẦN ĐI KHÁM NGAY',
      imageUrl: 'assets/images/news8.jpg',
      date: '05/02/2023',
      time: '08:45',
      tags: const [],
      category: 'Cẩm nang tiên chủng',
    ),
  ];

  // Các danh mục tin tức
  static const List<CategoryItem> _categories = [
    CategoryItem(title: 'Bệnh truyền nhiễm', count: 69),
    CategoryItem(title: 'Lịch tiêm chủng', count: 22),
    CategoryItem(title: 'Thông tin ưu đãi', count: 0),
    CategoryItem(title: 'Cẩm nang tiên chủng', count: 0),
    CategoryItem(title: 'Thông tin khai trương', count: 0),
    CategoryItem(title: 'Tin tức và kiến thức', count: 0),
    CategoryItem(title: 'Vắc xin người lớn', count: 0),
    CategoryItem(title: 'Vắc xin trẻ em', count: 0),
  ];

  int _selectedCategoryIndex = 0;
  
  // Lấy danh sách tin tức theo danh mục đã chọn
  List<NewsItem> get _filteredNewsItems {
    final selectedCategory = _categories[_selectedCategoryIndex].title;
    
    // Nếu index = 0, hiển thị tất cả tin tức (có thể thay đổi logic này)
    if (_selectedCategoryIndex == 0) {
      return _allNewsItems.where((item) => item.category == selectedCategory).toList();
    }
    
    // Lọc tin tức theo danh mục
    return _allNewsItems.where((item) => item.category == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(),
        _buildCategorySelector(),
        _buildNewsListView(),
      ],
    );
  }

  Widget _buildSectionHeader() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Tin tức và Kiến thức',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            _categories.length,
            (index) => _buildCategoryItem(_categories[index], index),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(CategoryItem category, int index) {
    final bool isSelected = _selectedCategoryIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedCategoryIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              category.title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 12,
              ),
            ),
            if (category.count > 0) ...[
              const SizedBox(width: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${category.count}',
                  style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNewsListView() {
    final List<NewsItem> newsToShow = _filteredNewsItems;
    
    if (newsToShow.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            'Không có tin tức nào trong danh mục này',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
    
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      itemCount: newsToShow.length,
      separatorBuilder: (_, __) => const Divider(height: 16.0),
      itemBuilder: (context, index) => NewsItemWidget(newsItem: newsToShow[index]),
    );
  }
}

// Model cho danh mục tin tức
class CategoryItem {
  final String title;
  final int count;

  const CategoryItem({
    required this.title,
    required this.count,
  });
}

// Model cho tin tức
class NewsItem {
  final String title;
  final String imageUrl;
  final String date;
  final String time;
  final List<String> tags;
  final String category; // Thêm trường category

  const NewsItem({
    required this.title,
    required this.imageUrl,
    required this.date, 
    required this.time,
    required this.tags,
    required this.category, // Thêm tham số bắt buộc
  });

  // Phương thức tiện ích để hiển thị thời gian
  String get formattedDateTime => '$date${time.isNotEmpty ? ' $time' : ''}';
}

class NewsItemWidget extends StatelessWidget {
  final NewsItem newsItem;

  const NewsItemWidget({Key? key, required this.newsItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildNewsImage(),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNewsTitle(),
              const SizedBox(height: 8),
              _buildNewsMeta(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNewsImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.asset(
        newsItem.imageUrl,
        width: 100,
        height: 70,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 100,
          height: 70,
          color: Colors.grey[300],
          child: const Icon(Icons.image, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildNewsTitle() {
    return Text(
      newsItem.title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildNewsMeta() {
    return Row(
      children: [
        if (newsItem.tags.isNotEmpty) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              newsItem.tags.first,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
          const SizedBox(width: 8),
        ],
        Text(
          newsItem.formattedDateTime,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }
}