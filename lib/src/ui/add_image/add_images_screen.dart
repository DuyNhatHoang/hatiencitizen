import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:ha_tien_app/src/utils/my_colors.dart';
import 'package:ha_tien_app/src/utils/my_widget.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class AddImageScreen extends StatefulWidget {
  static const String routeName = "/AddImageScreen";
  final List<Asset> images;

  const AddImageScreen({Key key, this.images}) : super(key: key);

  @override
  _AddImageScreenState createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen>
    with TickerProviderStateMixin {
  List<Asset> images;

  Animation<double> _animation;
  AnimationController _animationController;
  List<Bubble> bubbleList;

  @override
  void initState() {
    super.initState();
    images = widget.images;
  }

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    initBubbleList(context);
    return Scaffold(
      appBar: buildMyAppBar(
        automaticallyImplyLeading: false,
        title: "Thêm ảnh",
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (orientation == Orientation.portrait) ? 3 : 4),
            itemCount: images.length,
            itemBuilder: (context, index) => Stack(
              children: [
                Container(
                    padding: EdgeInsets.all(8),
                    child: AssetThumb(
                      asset: images[index],
                      width: 300,
                      height: 300,
                    )),
                Positioned(
                  child: GestureDetector(
                    onTap: () => _onTapRemoveImage(index),
                    child: Icon(
                      Icons.remove_circle_outlined,
                      color: Colors.red,
                    ),
                  ),
                  top: 0,
                  right: 0,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionBubble(
        // Menu items
        items: bubbleList,

        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress: () => {Navigator.of(context).pop()},

        // onPress: _animationController.isCompleted
        //     ? _animationController.reverse
        //     : _animationController.forward,

        // Floating Action button Icon color
        iconColor: Colors.red,

        // Flaoting Action button Icon
        icon: AnimatedIcons.menu_close,
      ),
    );
  }

  _onTapRemoveImage(index) {
    setState(() {
      images.removeAt(index);
    });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = images;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: kPrimaryColorString,
          actionBarTitle: "Thư mục ảnh",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e.toString());
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
    });
  }

  _onTapBack(context) {
    Navigator.pop(context, images);
  }

  void initBubbleList(context) {
    bubbleList = List<Bubble>();
    var them = Bubble(
      title: "Thư viện",
      iconColor: kWhiteColor,
      bubbleColor: Colors.orangeAccent,
      icon: Icons.photo_library_sharp,
      titleStyle: TextStyle(fontSize: 16, color: Colors.white),
      onPress: () {
        loadAssets();
      },
    );
    var tiepNhan = Bubble(
      title: "Xong",
      iconColor: kWhiteColor,
      bubbleColor: Colors.green,
      icon: Icons.done,
      titleStyle: TextStyle(fontSize: 16, color: Colors.white),
      onPress: () {
        _onTapBack(context);
      },
    );

    bubbleList.add(them);
    bubbleList.add(tiepNhan);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    _animationController.forward();
  }
}
