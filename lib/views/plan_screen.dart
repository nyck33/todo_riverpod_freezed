///inherited widget includes Theme, Scaffold and many others
///.of(context) methods available
///inherited are immutable for lifecycle of app
///
///final updatedPlans = ref.watch(plansProvider.notifier).plans;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:master_plan/controllers/plan_controller.dart';

import '../models/data_layer.dart';
import '../plan_provider.dart';

class PlanScreen extends ConsumerStatefulWidget {
  //final Plan plan; //referred to by widget.plan! later
  final Plan plan;
  final String planName;

  //instantiae PlanScreen with instance of Plan as member
  PlanScreen({Key? key, required this.plan, required this.planName})
      : super(key: key);

  @override
  _PlanScreenState createState() => _PlanScreenState();
  //_PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends ConsumerState<PlanScreen> {
  //get rid of keyboard on iOS by removing focus from textfield
  late ScrollController scrollController;
  final textController = TextEditingController();

  //getter for plan, so widget refers to this object's instance
  ///do these interfere with getter in Plan get PlanTasks?
  ///or with the provider?
  Plan get plan => widget.plan;
  List<Task> get tasks => widget.plan.tasks!;
  String get planName => widget.plan.name!;

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
    final planController = ref.watch(plansProvider.notifier);
    final plans = ref.watch(plansProvider);

    return Scaffold(
      appBar: AppBar(title: Text("plan: $planName")),
      body: Column(
        children: [
          Expanded(child: _buildTasksList()),
          SafeArea(child: Text(plan.completenessMessage!))
        ],
      ),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  Widget _buildAddTaskButton() {
    final planController = ref.watch(plansProvider.notifier);

    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            print('before tasks: $tasks');
            //ref.read(plansProvider.notifier).createNewTask(plan);
            planController.createNewTask(plan);
            //plan.tasks.add(Task());

            print('after tasks: $tasks');
          });
        });
  }

  Widget _buildTasksList() {
    print('in buildTaskList');
    final plans = ref.watch(plansProvider);
    print('plans: $plans');
    Plan? thisPlan;
    for (Plan p in plans) {
      if ((p.name!) == planName) {
        thisPlan = p.copyWith(name: p.name!, tasks: p.tasks!);
        //thisPlan = p;
        break;
      }
    }
    if (thisPlan == null) {
      thisPlan = Plan();
    }
    final List<Task> updatedTasks = thisPlan.tasks!;

    return ListView.builder(
        controller: scrollController,
        itemCount: updatedTasks.length,
        //itemCount: tasks.length,
        //param context not needed?
        itemBuilder: (_, index) => _buildTaskTile(
              updatedTasks[index],
            ));
  }

  Widget _buildTaskTile(Task task) {
    final planController = ref.watch(plansProvider.notifier);
    print('in buidlTaskTile');
    late Task newTask;
    return ListTile(
      leading: Checkbox(
          //read boolean value in data model
          value: task.complete,

          ///calls the getter like this?
          //(va) returned from widget view
          onChanged: (selected) {
            //newTask = Task(description: task.description, complete: selected!)
            newTask = task.copyWith(
                description: task.description!, complete: selected!);
            setState(() {
              print('selected: $selected, task: ${task.description!}'); //t or f
              //task = newTask;
              //task.complete = selected!;
              //ref.read(plansProvider.notifier).updateTask(plan, task, newTask);
              planController.updateTask(plan, task, newTask);
              print('checkbox task: $task');
            });
          }),
      title: TextFormField(
        initialValue: task.description!,

        ///calls getter like this?
        onFieldSubmitted: (text) {
          //newTask = Task(description: text, complete: task.complete);
          newTask = task.copyWith(description: text, complete: task.complete!);
          setState(() {
            //task.description = text;
            //task = task.copyWith(description: text);
            //task = newTask;
            //ref.read(plansProvider.notifier).updateTask(plan, task, newTask);
            planController.updateTask(plan, task, newTask);

            print('task.description: $task');
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
