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
  //getter for plan, so widget refers to this object's instance
  Plan get plan => widget.plan;
  List<Task> get tasks => widget.plan.tasks;
  String get planName => widget.plan.name;

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
    final plans = ref.watch(plansProvider.notifier).plans;

    return Scaffold(
      appBar: AppBar(title: Text("plan: $planName")),
      body: Column(
        children: [
          Expanded(child: _buildTasksList()),
          SafeArea(child: Text(plan.completenessMessage))
        ],
      ),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  Widget _buildAddTaskButton() {
    final plans = ref.watch(plansProvider.notifier).plans;
    late final Plan thisPlan;
    for (Plan p in plans) {
      if (p.name == planName) {
        thisPlan = p;
      }
    }
    final thisTasks = thisPlan.tasks;
    final planController = ref.watch(plansProvider.notifier);

    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          setState(() {
            print('before plan.tasks: ${plan.tasks}');
            planController.createNewTask(plan);
            //plan.tasks.add(Task());

            print('after plan.tasks: ${plan.tasks}');
          });
        });
  }

  Widget _buildTasksList() {
    final plans = ref.watch(plansProvider.notifier).plans;
    late final Plan thisPlan;
    for (Plan p in plans) {
      if (p.name == planName) {
        thisPlan = p;
      }
    }

    return ListView.builder(
        controller: scrollController,
        itemCount: thisPlan.tasks.length,
        //param context not needed?
        itemBuilder: (_, index) => _buildTaskTile(
              thisPlan.tasks[index],
            ));
  }

  Widget _buildTaskTile(Task task) {
    late Task newTask;
    return ListTile(
      leading: Checkbox(
          //read boolean value in data model
          value: task.complete,
          //(va) returned from widget view
          onChanged: (selected) {
            newTask = Task(description: task.description, complete: selected!);
            setState(() {
              print('selected: $selected, task: ${task.description}'); //t or f
              task = newTask;
              print('checkbox task: $task');
            });
          }),
      title: TextFormField(
        initialValue: task.description,
        onFieldSubmitted: (text) {
          newTask = Task(description: text, complete: task.complete);
          setState(() {
            //task.description = text;
            //task = task.copyWith(description: text);
            task = newTask;
            print('task.description: $task');
          });
        },
      ),
    );
  }
}
