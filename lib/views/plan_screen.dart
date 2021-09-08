///inherited widget includes Theme, Scaffold and many others
///.of(context) methods available
///inherited are immutable for lifecycle of app
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';

import '../models/data_layer.dart';
import 'package:flutter/material.dart';
import '../plan_provider.dart';

class PlanScreen extends ConsumerStatefulWidget {
  final Plan? plan; //referred to by widget.plan! later
  final String? planName;
  //instantiae PlanScreen with instance of Plan as member
  const PlanScreen({Key? key, @required this.plan, @required this.planName})
      : super(key: key);

  @override
  _PlanScreenState createState() => _PlanScreenState();
  //_PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends ConsumerState<PlanScreen> {
  //list of tasks
  //final plan = Plan();
  //get rid of keyboard on iOS by removing focus from textfield
  late ScrollController scrollController;
  //getter for plan, so widget refers to this object's instance
  Plan get plan => widget.plan!;
  String get planName => widget.plan!.name;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController()
      //cascades, returns reference to ScrollController() object
      //instantiate then call addListener()
      //moves focus from any textfield during scroll event
      ..addListener(() {
        //FocusScope.of(context): find focusnode for buildcontext
        //inherited widget
        FocusScope.of(context).requestFocus(FocusNode());
      });
    //ref.watch(plansProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("plan: $planName")), //change to plan name
      body: Column(
        children: [
          Expanded(child: _buildList()),
          SafeArea(child: Text(plan.completenessMessage))
        ],
      ),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  Widget _buildAddTaskButton() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            plan.tasks.add(Task());
          });
        });
  }

  Widget _buildList() {
    return ListView.builder(
        controller: scrollController,
        itemCount: plan.tasks.length,
        //param context not needed?
        itemBuilder: (_, index) => _buildTaskTile(
              plan.tasks[index],
            ));
  }

  Widget _buildTaskTile(Task task) {
    return ListTile(
      leading: Checkbox(
          //read boolean value in data model
          value: task.complete,
          //(va) returned from widget view
          onChanged: (selected) {
            //selected is also bool
            //set the value in data model
            setState(() {
              print('selected: $selected, task: ${task.description}'); //t or f
              //task.complete = selected!;
              task = task.copyWith(complete: selected!);
            });
          }),
      title: TextFormField(
        initialValue: task.description,
        onFieldSubmitted: (text) {
          setState(() {
            //task.description = text;
            task = task.copyWith(description: text);
          });
        },
      ),
    );
  }
}
