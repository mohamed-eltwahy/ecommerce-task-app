import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'filter_button_widget.dart';
import 'search_bar_widget.dart';

class SearchAndFilterSection extends StatelessWidget {
  final TextEditingController? searchController;
  final Function(String)? onSearchChanged;
  final VoidCallback? onClearSearch;
  final VoidCallback? onFilterTap;
  final String searchHintText;

  const SearchAndFilterSection({
    super.key,
    this.searchController,
    this.onSearchChanged,
    this.onClearSearch,
    this.onFilterTap,
    this.searchHintText = 'Search for a meal',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SearchBarWidget(
            controller: searchController,
            onChanged: onSearchChanged,
            onClear: onClearSearch,
            hintText: searchHintText,
          ),
        ),
        SizedBox(width: 8.w),
        FilterButtonWidget(onTap: onFilterTap),
      ],
    );
  }
}
