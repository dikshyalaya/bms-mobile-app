import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/domain/manage_shift_provider.dart';
import 'package:beacon_flutter/features/manager_dashboard/manage_shifts/model/requested_dsp_model.dart';

void showSearchDialog(BuildContext context) async {
  final shiftProvider = context.read<ManageShiftProvider>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          final TextEditingController searchKeywordController = TextEditingController();

          return Consumer<ManageShiftProvider>(
            builder: (context, shiftProviderhere, _) {
              return AlertDialog(
                title: const Text('Select Item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: searchKeywordController,
                      onChanged: (value) async {
                        await shiftProvider.getRequestedDsp(value);
                        // setState(() {}); // Ensure the dialog rebuilds
                      },
                      decoration: const InputDecoration(
                        labelText: 'Search',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    shiftProviderhere.allRequestedDspModel?.data.isNotEmpty == true
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: shiftProviderhere.allRequestedDspModel!.data.length,
                              itemBuilder: (context, index) {
                                final item = shiftProviderhere.allRequestedDspModel!.data[index];
                                return ListTile(
                                  title: Text(item.empDetail ?? 'No detail'),
                                  onTap: () {
                                    Navigator.of(context).pop(item);
                                  },
                                );
                              },
                            ),
                          )
                        : (searchKeywordController.text.isEmpty
                            ? const Text('Type to Search', style: TextStyle(color: Colors.black))
                            : const Text('No results found', style: TextStyle(color: Colors.red))),
                  ],
                ),
              );
            },
          );
        },
      );
    },
  );
}
