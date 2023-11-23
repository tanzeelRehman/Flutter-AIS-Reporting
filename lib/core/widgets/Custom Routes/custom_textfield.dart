import 'dart:ui';

import 'package:ais_reporting/core/utils/globals/globals.dart';
import 'package:ais_reporting/core/widgets/Custom%20Routes/Popups/show_pop_up.dart';
import 'package:ais_reporting/core/widgets/Custom%20Routes/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.focusNode,
    this.validator,
    this.isPasswordField = false,
    this.keyboardType = TextInputType.text,
    this.checkEmptyString = true,
    this.shouldShowSearchBar = false,
    this.isReadOnly = false,
    this.maxLines = 1,
    this.dropdownValues,
    this.onValueSelect,
    this.onTap,
    this.title,
    this.titleWidth,
    this.onChange,
    this.inputFormaters,
    this.color,
    this.suffix,
    this.dropdownSize,
    this.borderRadius,
    this.typingTextColor,
    this.putTitleInRow = false,
    this.passwordIcon,
  }) : super(key: key);
  final String? title;

  /// used when putTile in row is true
  final double? titleWidth;
  final TextEditingController controller;
  final bool isPasswordField;
  final bool shouldShowSearchBar;
  final String hintText;
  final bool checkEmptyString;
  final bool isReadOnly;
  final FocusNode? focusNode;
  final Icon? passwordIcon;

  /// provide empty body to make it read only
  final Function()? onTap;
  final Function(String)? onValueSelect;
  final Function(String)? onChange;
  final int maxLines;
  final TextInputType keyboardType;
  final Widget? icon;
  final Color? color;
  final Color? typingTextColor;
  final Widget? suffix;
  final List<String>? dropdownValues;
  final BorderRadius? borderRadius;
  final List<TextInputFormatter>? inputFormaters;
  final bool putTitleInRow;
  String? Function(String?)? validator;
  Size? dropdownSize;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isPasswordShow = false;

  ///
  final FocusNode _focusNode = FocusNode();

  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null && !widget.putTitleInRow)
              Padding(
                padding: const EdgeInsets.only(left: 5, bottom: 12),
                child: Text(widget.title!),
              ),
            const SizedBox(width: 20),
            Row(
              children: [
                if (widget.title != null && widget.putTitleInRow)
                  SizedBox(
                    width: widget.titleWidth,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 0, bottom: 12, right: 20),
                      child: Text(widget.title!),
                    ),
                  ),
                Expanded(
                  child: TextFormField(
                    key: _key,
                    controller: widget.controller,
                    focusNode: widget.focusNode ?? _focusNode,
                    validator: widget.validator ??
                        (val) {
                          if (val != null) {
                            if (val.isEmpty && widget.checkEmptyString) {
                              return "Field cannot be submitted empty";
                            }
                          }
                          return null;
                        },
                    readOnly: widget.dropdownValues != null ||
                        widget.onTap != null ||
                        widget.isReadOnly,
                    onChanged: widget.onChange,
                    inputFormatters: widget.inputFormaters,
                    onTap: widget.dropdownValues != null
                        ? () async {
                            if (widget.onTap != null) {
                              _focusNode.unfocus();
                              return widget.onTap!();
                            }
                            _focusNode.unfocus();

                            var res = await showPopUp(
                              context: navigatorKeyGlobal.currentContext!,
                              heroTag: widget.hintText,
                              rect: _key.location,
                              size: const Size(0, 60),
                              child: (onValueSelect) => SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: PopupListView(
                                  dropdownValues: widget.dropdownValues,
                                  shouldIncludeSearchBar:
                                      widget.shouldShowSearchBar,
                                  size: widget.dropdownSize,
                                  onValueSelect: onValueSelect,
                                ),
                              ),
                            );
                            if (res is String) {
                              widget.controller.text = res;
                              if (widget.onValueSelect != null) {
                                widget.onValueSelect!(res);
                              }
                              setState(() {});
                            }
                          }
                        : widget.onTap,
                    obscureText: widget.isPasswordField && !isPasswordShow,
                    maxLines: widget.maxLines,
                    keyboardType: widget.keyboardType,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: widget.typingTextColor ?? Colors.white),
                    decoration: InputDecoration(
                        // border: const OutlineInputBorder(
                        //     borderSide: BorderSide(color: Colors.black, width: 1)),
                        filled: true,
                        focusColor: Colors.black,
                        iconColor: Colors.black,
                        prefix:
                            const Padding(padding: EdgeInsets.only(left: 10)),
                        suffixIcon: widget.isPasswordField
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isPasswordShow = !isPasswordShow;
                                  });
                                },
                                child: Icon(
                                  (widget.passwordIcon?.icon) ?? Icons.pin,
                                  color: isPasswordShow
                                      ? Colors.blue
                                      : Colors.black26,
                                ),
                              )
                            : widget.dropdownValues != null
                                ? Transform.translate(
                                    offset: const Offset(0, 3),
                                    child: const IgnorePointer(
                                        child: Icon(Icons.arrow_drop_down)))
                                : widget.suffix,
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                widget.borderRadius ?? BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2)),
                        border: OutlineInputBorder(
                            borderRadius:
                                widget.borderRadius ?? BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: widget.color ?? Colors.transparent,
                                width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                widget.borderRadius ?? BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: widget.color ?? Colors.transparent,
                                width: 2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                                widget.borderRadius ?? BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 2)),
                        hintText: widget.hintText,
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: widget.color ??
                              Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.4),
                        ),
                        // suffixIcon:,
                        focusedBorder: widget.dropdownValues != null
                            ? null
                            : OutlineInputBorder(
                                borderRadius: widget.borderRadius ??
                                    BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: widget.color ??
                                        Theme.of(context).primaryColor,
                                    width: 3))),
                  ),
                ),
              ],
            ),
          ],
        ),
        if (widget.icon != null || widget.dropdownValues != null)
          Positioned(
            right: 8,
            top: 53,
            child: IgnorePointer(
              child: SizedBox(
                width: 50,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 10, bottom: widget.maxLines != 1 ? 60 : 0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: widget.icon ??
                          (widget.dropdownValues != null
                              ? const Icon(Icons.arrow_drop_down)
                              : widget.icon)),
                ),
              ),
            ),
          )
      ],
    );
  }
}

class PopupListView extends StatefulWidget {
  const PopupListView(
      {this.dropdownValues,
      required this.shouldIncludeSearchBar,
      this.size,
      required this.onValueSelect});
  final bool shouldIncludeSearchBar;
  final List<String>? dropdownValues;
  final Size? size;
  final Function onValueSelect;
  @override
  State<PopupListView> createState() => _PopupListViewState();
}

class _PopupListViewState extends State<PopupListView> {
  List<String>? searchedValues = [];
  TextEditingController cont = TextEditingController();
  final FocusNode node = FocusNode();
  @override
  void initState() {
    super.initState();
    searchedValues = widget.dropdownValues;
    node.addListener(() {
      setState(() {});
    });
  }

  void search(String search) {
    if (search.isEmpty) {
      searchedValues = widget.dropdownValues;
    } else {
      searchedValues = widget.dropdownValues!
          .where(
              (element) => element.toLowerCase().contains(search.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        height: (widget.size != null
                ? (((widget.dropdownValues!.length) * 65 +
                            (widget.shouldIncludeSearchBar ? 65 : 0)) >
                        widget.size!.height)
                    ? widget.size?.height
                    : widget.dropdownValues!.length * 65 +
                        20 +
                        (widget.shouldIncludeSearchBar ? 75 : 0)
                : 350)! +
            (widget.dropdownValues?.isEmpty ?? true ? 100 : 0),
        padding: const EdgeInsets.symmetric(vertical: 10),
        // margin: EdgeInsets.only(bottom: node.hasFocus ? 250 : 0),
        decoration: BoxDecoration(
          // color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(color: Colors.transparent),
        ),
        width: widget.size?.width ?? MediaQuery.of(context).size.width * 0.925,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.shouldIncludeSearchBar)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: cont,
                  focusNode: node,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                      hintText: "Search here",
                      contentPadding: EdgeInsets.only(left: 10),
                      fillColor: Colors.black12,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintStyle: TextStyle(color: Colors.grey)),
                  onChanged: (value) {
                    search(value);
                  },
                ),
              ),
            if (widget.dropdownValues!.isEmpty)
              const SizedBox(
                height: 100,
                child: Center(
                  child: Text("No Data Found"),
                ),
              ),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: ListView.builder(
                  itemCount: searchedValues!.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) => Padding(
                    padding:
                        const EdgeInsets.only(bottom: 5, left: 10, right: 10),
                    child: Material(
                      elevation: 4,
                      color: Colors.white,
                      child: ListTile(
                          title: Text(
                            searchedValues![index],
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          onTap: () =>
                              // Navigator.pop(context, searchedValues![index]),
                              widget.onValueSelect(searchedValues![index])),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// class PopupListView extends PopupWidget {
//   PopupListView({
//     Key? key,
//     required this.dropdownValues,
//     this.shouldIncludeSearchBar = false,
//   }) : super(key: key);
//   bool shouldIncludeSearchBar;
//   final List<String>? dropdownValues;
//   List<String>? searchedValues = [];

//   // void initState() {}
//   @override
//   void initState() {
    
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
