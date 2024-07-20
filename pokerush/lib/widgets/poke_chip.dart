import 'package:flutter/material.dart';

class FilterChipItem {
  final String label;
  final String value;

  FilterChipItem({
    required this.label,
    required this.value,
  });
}

class FilterChipDropdown extends StatefulWidget {
  final List<FilterChipItem> items;
  final Widget? leading;
  final String initialLabel;
  final Color unselectedColor;
  final Color unselectedLabelColor;
  final Color selectedColor;
  final Color selectedLabelColor;
  final Function(String?) onSelectionChanged;
  final double labelPadding;

  FilterChipDropdown({
    Key? key,
    required this.items,
    this.leading,
    required this.initialLabel,
    required this.unselectedColor,
    required this.unselectedLabelColor,
    required this.selectedColor,
    required this.selectedLabelColor,
    required this.onSelectionChanged,
    this.labelPadding = 16,
  }) : super(key: key);

  @override
  _FilterChipDropdownState createState() => _FilterChipDropdownState();
}

class _FilterChipDropdownState extends State<FilterChipDropdown> {
  final GlobalKey _chipKey = GlobalKey();
  final OverlayPortalController _tooltipController = OverlayPortalController();

  late String _selectedLabel;
  bool _isSelected = false;
  bool _isDropdownOpen = false;
  double _maxItemWidth = 0;
  

  @override
  void initState() {
    super.initState();
    _selectedLabel = widget.initialLabel;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateMaxItemWidth();
    });
  }

  void _toggleDropdown(bool? value) {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
      _tooltipController.toggle;
    });
  }

  void _selectItem(FilterChipItem item) {
    setState(() {
      _selectedLabel = item.label;
      _isSelected = true;
      _isDropdownOpen = false;
    });
    widget.onSelectionChanged(item.value);
  }

  void _clearSelection() {
    setState(() {
      _selectedLabel = widget.initialLabel;
      _isSelected = false;
      _isDropdownOpen = false;
    });
    widget.onSelectionChanged(null);
  }

  void _handleOutsideTap(PointerDownEvent evt) {
    if (_isDropdownOpen) {
      setState(() {
        _isDropdownOpen = false;
      });
    }
  }

  void _calculateMaxItemWidth() {
    double maxWidth = 0.0;
    for (var item in widget.items) {
      final textPainter = TextPainter(
        text: TextSpan(
            text: item.label, style: DefaultTextStyle.of(context).style),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout();
      maxWidth = maxWidth < textPainter.width
          ? textPainter.width + 2 * widget.labelPadding
          : maxWidth;
    }

    final chipBox = _chipKey.currentContext?.findRenderObject() as RenderBox?;
    double chipWidth = chipBox?.size.width ?? 0;
    setState(() {
      _maxItemWidth = maxWidth > chipWidth ? maxWidth : chipWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: _handleOutsideTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FilterChip.elevated(
              key: _chipKey,
              avatar: widget.leading,
              label: Text(
                _selectedLabel,
              ),
              iconTheme: IconThemeData(
                color: _isSelected
                    ? widget.selectedLabelColor
                    : widget.unselectedLabelColor,
              ),
              labelStyle: TextStyle(
                color: _isSelected
                    ? widget.selectedLabelColor
                    : widget.unselectedLabelColor,
              ),
              backgroundColor:
                  _isSelected ? widget.selectedColor : widget.unselectedColor,
              deleteIcon: _isSelected
                  ? Icon(Icons.close, color: widget.selectedLabelColor)
                  : Icon(Icons.arrow_drop_down,
                      color: widget.unselectedLabelColor),
              onDeleted:
                  _isSelected ? _clearSelection : () => _toggleDropdown(false),
              onSelected: _toggleDropdown),
          if (_isDropdownOpen)
            Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(4),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: _maxItemWidth,
                      maxWidth: MediaQuery.of(context).size.width * 0.9,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.items.map((item) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _selectItem(item),
                            child: Container(
                              width: _maxItemWidth,
                              padding: EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: widget.labelPadding),
                              child: Text(item.label),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
