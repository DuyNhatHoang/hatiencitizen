import 'package:commons/src/functions/functions.dart';
import 'package:commons/src/functions/navigation_functions.dart';
import 'package:commons/src/models/models.dart';
import 'package:flutter/material.dart';

typedef SearchUser = void Function(String);

class __SelectionDialog extends StatefulWidget {
  final String title;
  final Set<Data> items;
  final Function onSubmit;
  final Set<Data> selectedItems;
  final bool multiSelect;
  final SearchUser searchUser;
  final bool searchable;
  final String submitButtonText;

  __SelectionDialog(
    this.title,
    this.items,
    this.onSubmit, {
    this.submitButtonText,
    this.selectedItems,
    this.multiSelect,
    this.searchable,
    this.searchUser,
  });

  @override
  ___SelectionDialogState createState() => ___SelectionDialogState();
}

class ___SelectionDialogState extends State<__SelectionDialog> {
  bool _showSearchField = true;
  String _searchQuery = "";
  Set<Data> _selectedItems = Set();
  Set<Data> _filteredList;
  final _searchBarFieldController = TextEditingController();
  FocusNode _searchBarFieldFocusNode = FocusNode();

  _optionItem(BuildContext context, Data data) {
    return widget.multiSelect
        ? CheckboxListTile(
            value: _selectedItems.contains(data),
            onChanged: (value) {
              setState(() {
                data.selected = value;
              });
              if (data.selected) {
                _selectedItems.add(data);
              } else {
                _selectedItems.remove(data);
              }
            },
            title: highlightTitleTextWidget(
                context, "${data.title}", _searchQuery),
          )
        : ListTile(
            onTap: () {
              pop(context);
              widget.onSubmit(data);
            },
            title: highlightTitleTextWidget(
                context, "${data.title}", _searchQuery),
          );
  }

  _options() {
    var listItems = List<Widget>();
    _filteredList.forEach((item) {
      listItems.add(_optionItem(context, item));
    });
    return listItems;
  }

  _getTitle() {
    if (widget.searchable) {
      return Row(
        children: <Widget>[
          Expanded(
            child: _showSearchField
                ? Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextField(
                      maxLength: 20,
                      focusNode: _searchBarFieldFocusNode,
                      controller: _searchBarFieldController,
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm cán bộ...",
                        counterText: "",
                      ),
                      onChanged: (value) {
                        widget.searchUser(value);
                      },
                    ),
                  )
                : Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _searchBarFieldController.clear();
                  _searchQuery = "";
                  _showSearchField = !_showSearchField;

                  delay(Duration(milliseconds: 100), () {
                    if (_showSearchField) {
                      FocusScope.of(context)
                          .requestFocus(_searchBarFieldFocusNode);
                    } else {
                      FocusScope.of(context).requestFocus(FocusNode());
                    }
                  });
                });
              },
            ),
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
    }
  }

  _dialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _getTitle(),
        Divider(
          color: Colors.black,
          height: 5,
        ),
        _filteredList.isEmpty
            ? Expanded(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 64,
                      ),
                      Image.asset(
                        "assets/images/empty.png",
                        package: "commons",
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                      ),
                      Text(
                        "Empty Collections",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 64,
                      ),
                    ],
                  ),
                ),
              )
            : AnimatedContainer(
                duration: Duration(milliseconds: 1000),
                child: Flexible(
                  fit: FlexFit.tight,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ..._options(),
                      ],
                    ),
                  ),
                ),
              ),
        if (widget.multiSelect)
          Divider(
            color: Colors.black,
            height: 5,
          ),
        if (widget.multiSelect)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    _filteredList.forEach((item) => item.selected = false);
                    _selectedItems.clear();
                  });
                },
                child: Text("Un-Select All"),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    _filteredList.forEach((item) => item.selected = true);
                    _selectedItems.addAll(_filteredList);
                  });
                },
                child: Text("Select All"),
              ),
              FlatButton(
                onPressed: () {
                  if (widget.onSubmit != null) widget.onSubmit(_selectedItems);
                  pop(context); // To close the dialog
                },
                child: Text(widget.submitButtonText ?? "Done"),
              ),
            ],
          ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _filteredList = widget.items;
    if (widget.selectedItems != null) {
      _selectedItems = widget.selectedItems;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 350,
        ),
        child: _dialogContent(context),
      ),
      elevation: 3,
    );
  }
}

myMultiSearchDialog<T extends Data>(
  BuildContext context,
  String title,
  Set<T> dataList,
  Set<T> selectedItems,
  SearchUser searchUser,
  Function onSubmit, {
  autoClose = true,
  searchable = true,
}) {
  return showDialog(
    barrierDismissible: autoClose,
    context: context,
    builder: (c) => WillPopScope(
      onWillPop: () async => autoClose,
      child: __SelectionDialog(
        title,
        dataList,
        onSubmit,
        selectedItems: selectedItems,
        searchUser: searchUser,
        multiSelect: true,
        searchable: searchable,
      ),
    ),
  );
}
