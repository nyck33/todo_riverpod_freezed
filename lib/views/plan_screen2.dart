///top level screen of all plans with text field at top for new plans
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';

import '../models/data_layer.dart';
import '../plan_provider.dart';

class PlanScreen extends ConsumerStatefulWidget {
  final Plan plan;
  final String planName;
  //List<Task> taskList;

  const PlanScreen({Key? key, required this.plan, required this.planName})
      : super(key: key);

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends ConsumerState<PlanScreen> {
  //List<Plan> _plans; //= ref.watch(plansProvider.notifier);

  //for creating simple Textfields for new plans
  final textController = TextEditingController();
  Plan get plan => widget.plan;
  //List<Task> get tasks => plan.planTasks;
  String get thisName => widget.planName;

  @override
  Widget build(BuildContext context) {
    //this gives me the List<Plan>
    final List<Plan> plans = ref.watch(plansProvider);
    //_plans = ref.watch(plansProvider);
    print('plancreator build plans length: ${plans.length}');
    //final plans = ref.watch(plansProvider);
    //next way with "notifier" can pick which state to get
    //final plans = ref.read(plansProvider.notifier).plans;

    return Scaffold(
      appBar: AppBar(title: Text('Master Plans')),
      body: Column(
        children: <Widget>[
          _buildTaskCreator(), //textfield and func to add plan on tap
          Expanded(child: _buildPlanTasks()),
          SafeArea(child: Text(plan.completenessMessage!)),
        ],
      ),
      //floatingActionButton: _buildAddTaskButton,
    );
  }

  Widget _buildTaskCreator() {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          //makes field pop out
          color: Theme.of(context).cardColor,
          elevation: 10,
          child: TextField(
              controller: textController,
              decoration: InputDecoration(
                  labelText: 'Add a Task', contentPadding: EdgeInsets.all(20)),
              onEditingComplete: addTask),
        ));
  }

  ///check if user typed something into field and reset screen
  void addTask() {
    final text = textController.text;

    ///remove all business logic
    //if (text.isEmpty) {
    //return; //don't add blanks
    //}
    //this is method 1
    //final planController = ref.read(plansProvider.notifier);
    //planController.addNewPlan(text);

    //method 2 with watch
    final planController = ref.watch(plansProvider.notifier);

    planController.createNewTask(plan, text);
    //instance of PlanController
    //method 3 with listen is wrong but something like this,
    //ref is passed since this is a method in ConsumerState
    //ref.listen<List<Plan>>(plansProvider, (List<Plan> plans) {
    //final plan = Plan()..name = text;
    //plans = [...plans, plan];

    textController.clear();
    //request focus
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  ///read data from PlanProvider and print to screen
  Widget _buildPlanTasks() {
    //final plans = ref.read(plansProvider.notifier).plans;

    //unmodifiable list
    final updatedPlans = ref.watch(plansProvider.notifier).plans;
    final planController = ref.watch(plansProvider.notifier);

    if (updatedPlans.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.note, size: 100, color: Colors.grey),
          Text('No tasks yet', style: Theme.of(context).textTheme.headline5)
        ],
      );
    }

    List<Task> updatedTasks = [];
    for (Plan p in updatedPlans) {
      if (p.name == thisName) {
        updatedTasks = p.tasks!;
        break;
      }
    }

    return ListView.builder(
      itemCount: updatedTasks.length,
      itemBuilder: (context, index) {
        Task task = updatedTasks[index];
        return ListTile(
          leading: Checkbox(
              value: task.complete,
              onChanged: (selected) {
                setState(() {
                  final Task compTask = task.copyWith(
                      description: task.description, complete: selected);
                  //task = compTask;
                  planController.updateTask(plan, task, compTask);
                });
              }),
          title: Text(task.description!),
          //subtitle: Text(plan.completenessMessage),
        );
      },
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
