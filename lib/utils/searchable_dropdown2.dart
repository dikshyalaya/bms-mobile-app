// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class SearchableDropdown<T> extends StatefulWidget {
//   final List<T> items;
//   final String Function(T) itemAsString;
//   final T? selectedItem;
//   final ValueChanged<T?> onChanged;
//   final String hintText;
//   final Future<void> Function(String? query)? onSearch; // Callback for API calls

//   const SearchableDropdown({
//     Key? key,
//     required this.items,
//     required this.itemAsString,
//     required this.selectedItem,
//     required this.onChanged,
//     this.hintText = '',
//     this.onSearch, // Initialize the callback
//   }) : super(key: key);

//   @override
//   _SearchableDropdownState<T> createState() => _SearchableDropdownState<T>();
// }

// class _SearchableDropdownState<T> extends State<SearchableDropdown<T>> {
//   late List<T> _filteredItems;
//   TextEditingController _searchQuery = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _filteredItems = widget.items;
//   }

//   Future<void> _filterItems(String query) async {
//     setState(() {
//       _searchQuery.text = query;
//     });

//     if (widget.onSearch != null) {
//       await widget.onSearch!(query); // Call the API callback
//     }

//     setState(() {
//       _filteredItems = widget.items
//           .where((item) => widget.itemAsString(item)
//               .toLowerCase()
//               .contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () async {
//         await showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return Dialog(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       controller: _searchQuery,
//                       autofocus: true,
//                       decoration: InputDecoration(
//                         hintText: 'Search...',
//                         border: OutlineInputBorder(),
//                       ),
//                       onChanged: _filterItems,
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView(
//                       children: _filteredItems
//                           .map((item) => ListTile(
//                                 title: Text(widget.itemAsString(item)),
//                                 onTap: () {
//                                   Navigator.of(context).pop();
//                                   widget.onChanged(item);
//                                 },
//                               ))
//                           .toList(),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: const Color(0xffA9A9A9)),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 widget.selectedItem != null
//                     ? widget.itemAsString(widget.selectedItem!)
//                     : widget.hintText,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.normal,
//                   color: widget.selectedItem == null
//                       ? Colors.grey
//                       : Colors.black,
//                 ),
//               ),
//             ),
//             const Icon(Icons.arrow_drop_down),
//           ],
//         ),
//       ),
//     );
//   }
// }
