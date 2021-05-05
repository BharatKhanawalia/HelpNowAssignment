import 'package:flutter/material.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:helpnow_assignment/constants.dart';
import 'package:helpnow_assignment/models/form.dart';
import 'package:helpnow_assignment/models/form_service.dart';
import 'package:helpnow_assignment/screens/form_screen.dart';

class HomeScreen extends StatefulWidget {
  @override 
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  var _formService = FormService();
  List<FormData> _formList = List<FormData>.empty(growable: true);

  getAllForms() async {
    _formList = List<FormData>.empty(growable: true);
    var forms = await _formService.readForms();
    forms.forEach((form) {
      setState(() {
        var formModel = FormData();
        formModel.id = form['id'];
        formModel.name = form['name'];
        formModel.mobile = form['mobile'];
        formModel.productType = form['productType'];
        formModel.amount = form['amount'];
        formModel.amountType = form['amountType'];
        formModel.printDate = form['date'];
        // formModel.image = form['image'];
        _formList.add(formModel);
      });
    });
  }

  @override
  void initState() {
    getAllForms();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionBubble(
        // Menu items
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title: "Add Entry",
            iconColor: kPrimaryColor,
            bubbleColor: kWhite,
            icon: Icons.add,
            titleStyle: TextStyle(
              fontSize: 16,
              color: kPrimaryColor,
              fontWeight: FontWeight.w400,
            ),
            onPress: () {
              _animationController.reverse();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormScreen()),
              );
            },
          ),
          // Floating action menu item
          Bubble(
            title: "Export",
            iconColor: kPrimaryColor,
            bubbleColor: kWhite,
            icon: Icons.upload_rounded,
            titleStyle: TextStyle(
              fontSize: 16,
              color: kPrimaryColor,
              fontWeight: FontWeight.w400,
            ),
            onPress: () {
              _animationController.reverse();
            },
          ),
          //Floating action menu item
        ],

        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),

        // Floating Action button Icon color
        iconColor: kWhite,

        // Flaoting Action button Icon
        iconData: Icons.menu,
        backGroundColor: kPrimaryColor,
      ),
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "Home Screen",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _formList.length > 0
          ? ListView.builder(
              itemCount: _formList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/placeholder_dp.png'),
                      ),
                      title: Text(
                        '${_formList[index].name} - ${_formList[index].mobile}',
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Text(_formList[index].printDate),
                      trailing: Text(
                        '₹ ${_formList[index].amount}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/placeholder.png',
                    width: 100,
                  ),
                  Text('No Entries Yet!'),
                ],
              ),
            ),
    );
  }
}
