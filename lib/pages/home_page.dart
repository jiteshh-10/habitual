import 'package:flutter/material.dart';
import 'package:habitual/components/habit_tile.dart';
import 'package:habitual/components/my_alert_box.dart';
import 'package:habitual/components/my_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //data structure for todays list
  List todaysHabitList = [
    //[habitName, habitCompleted]
    ["Morning Run", false],
    ["Read Book", false],
  ];

  //checkbox was tapped
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value;
    });
  }

//create a new habit
  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    //show alert dialog for user to enter the new habit details
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: _newHabitNameController,
          hintText: 'Enter Habit Name..',
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  //save new habit
  void saveNewHabit() {
    // add new habit to todays habit list
    setState(() {
      todaysHabitList.add([_newHabitNameController.text, false]);
    });
    // clear testflied
    _newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  //cancel new habit
  void cancelDialogBox() {
    // clear testflied
    _newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  //open habit settings to edit
  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
            controller: _newHabitNameController,
            hintText: todaysHabitList[index][0],
            onSave: () => saveExistingHabit(index),
            onCancel: cancelDialogBox);
      },
    );
  }

  // save exisiting habit with a new name
  void saveExistingHabit(int index) {
    setState(() {
      todaysHabitList[index][0] = _newHabitNameController.text;
      _newHabitNameController.clear();
      Navigator.pop(context);
    });
  }

  //delete habit
  void deleteHabit(int index) {
    setState(() {
      todaysHabitList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFloatinfActionButton(onPressed: createNewHabit),
      body: ListView.builder(
        itemCount: todaysHabitList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: todaysHabitList[index][0],
            habitCompleted: todaysHabitList[index][1],
            onChanged: (value) => checkBoxTapped(value, index),
            settingsTapped: (context) => openHabitSettings(index),
            deleteTapped: (context) => deleteHabit(index),
          );
        },
      ),
    );
  }
}
