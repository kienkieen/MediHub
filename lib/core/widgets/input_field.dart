import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String hintText;
  final IconData? prefixIcon;
  final bool isRequired;
  final bool enable;

  const InputField({
    super.key,
    this.controller,
    this.label,
    required this.hintText,
    this.prefixIcon,
    this.isRequired = false,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: label, style: TextStyle(fontSize: 16)),
                TextSpan(
                  text: isRequired ? ' *' : '',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ],
            ),
          ),
        const SizedBox(height: 4),
        TextField(
          controller: controller != null ? controller : null,
          enabled: enable,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade400),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

Widget buildPhoneInputField(
  TextEditingController controller,
  String label,
  String hintText, {
  String? Function(String?)? validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text.rich(
        TextSpan(
          children: [
            TextSpan(text: label, style: const TextStyle(fontSize: 16)),
            const TextSpan(
              text: ' *',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ],
        ),
      ),
      const SizedBox(height: 4),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade400, width: 1),
        ),
        child: Row(
          children: [
            // Country code selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey.shade400)),
              ),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/vietnam_flag.png",
                    width: 24,
                    height: 16,
                  ),
                  const SizedBox(width: 4),
                  const Text('+84', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            // Phone input
            Expanded(
              child: TextFormField(
                // Chuyển sang TextFormField để hỗ trợ validator
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: validator,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class DropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final bool isRequired;
  final ValueChanged<String?> onChanged;
  final EdgeInsetsGeometry? padding;
  final String? hintText;
  final FocusNode? focusNode;

  const DropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isRequired = false,
    this.padding,
    this.hintText,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: label, style: TextStyle(fontSize: 16)),
                TextSpan(
                  text: isRequired ? ' *' : '',
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ],
            ),
          ),
          const SizedBox(height: 2),
          GestureDetector(
            onTap: () {
              if (focusNode != null) {
                FocusScope.of(context).requestFocus(focusNode);
              } else {
                FocusScope.of(context).unfocus();
              }
              _showBottomSheet(context);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
              decoration: BoxDecoration(
                border: Border.all(width: 1.2, color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value ?? hintText ?? '',
                      style: TextStyle(
                        fontSize: 15,
                        color:
                            value == null ? Colors.grey.shade500 : Colors.black,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        TextEditingController searchController = TextEditingController();
        List<String> filteredItems = List.from(items);

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Chọn $label',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              filteredItems =
                                  items
                                      .where(
                                        (item) => item.toLowerCase().contains(
                                          value.toLowerCase(),
                                        ),
                                      )
                                      .toList();
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Tìm kiếm',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: _buildItem(() {
                            Navigator.pop(context);
                            onChanged(item);
                          }, item),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildItem(VoidCallback onPressed, String title) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12, width: 1)),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.grey.shade700,
            elevation: 0,
          ),

          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                fontFamily: 'Calistoga',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
