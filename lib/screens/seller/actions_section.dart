import 'package:flutter/material.dart';
import 'package:responsive_grid/responsive_grid.dart';

/// The actions section for the seller screen, containing quick action buttons and the item code field.
class ActionsSection extends StatefulWidget {
  const ActionsSection({Key? key}) : super(key: key);

  @override
  State<ActionsSection> createState() => _ActionsSectionState();
}

class _ActionsSectionState extends State<ActionsSection> {
  final TextEditingController _itemCodeController = TextEditingController();

  @override
  void dispose() {
    _itemCodeController.dispose();
    super.dispose();
  }

  void _onItemCodeChanged(String value) {
    // Sample callback: print or handle the input value
    print('Item code changed: $value');
    // You can add your logic here (e.g., search, validate, etc.)
  }

  @override
  Widget build(BuildContext context) {
    final actions = [
      _ActionButtonData(
        icon: Icons.qr_code_scanner,
        label: 'Scan Item',
        onPressed: () {
          // Add your button logic here
        },
      ),
      _ActionButtonData(
        icon: Icons.percent,
        label: 'Discount',
        onPressed: () {
          // Add your button logic here
        },
      ),
      _ActionButtonData(
        icon: Icons.pause_circle_filled,
        label: 'Hold Purchase',
        onPressed: () {
          // Add your button logic here
        },
      ),
      _ActionButtonData(
        icon: Icons.lock,
        label: 'Lock',
        onPressed: () {
          // Add your button logic here
        },
      ),
      _ActionButtonData(
        icon: Icons.swap_horiz,
        label: 'Transfer',
        onPressed: () {
          // Add your button logic here
        },
      ),
      _ActionButtonData(
        icon: Icons.print,
        label: 'Print',
        onPressed: () {
          // Add your button logic here
        },
      ),
      _ActionButtonData(
        icon: Icons.payment,
        label: 'Payment',
        onPressed: () {
          // Add your button logic here
        },
      ),
      _ActionButtonData(
        icon: Icons.close,
        label: 'Close',
        onPressed: () {
          // Add your button logic here
        },
      ),
    ];

    return ResponsiveGridRow(
      children: [
        ResponsiveGridCol(
          lg: 12,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Align(
              alignment: Alignment.center,
              child: _ItemCodeField(
                controller: _itemCodeController,
                onChanged: _onItemCodeChanged,
              ),
            ),
          ),
        ),
        ...actions.map(
          (action) => ResponsiveGridCol(
            xs: 12,
            md: 6,
            lg: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: _ActionButton(action: action),
            ),
          ),
        ),
      ],
    );
  }
}

class _ItemCodeField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _ItemCodeField({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[800],
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: "Item code",
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        prefixIcon: Icon(Icons.qr_code, color: Colors.grey[500]),
      ),
    );
  }
}

class _ActionButtonData {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  const _ActionButtonData({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
}

class _ActionButton extends StatelessWidget {
  final _ActionButtonData action;
  const _ActionButton({required this.action});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        onPressed: action.onPressed,
        icon: Icon(action.icon),
        label: Text(action.label),
      ),
    );
  }
}
