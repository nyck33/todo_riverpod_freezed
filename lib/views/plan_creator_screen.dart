///top level screen of all plans with text field at top for new plans
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:master_plan/controllers/plan_controller.dart';

import '../models/data_layer.dart';
import '../plan_provider.dart';
import 'plan_screen.dart';

class PlanCreatorScreen extends ConsumerStatefulWidget {
  const PlanCreatorScreen({Key? key}) : super(key: key);

  @override
  _PlanCreatorScreenState createState() => _PlanCreatorScreenState();
}

class _PlanCreatorScreenState extends ConsumerState<PlanCreatorScreen> {
  //List<Plan> _plans; //= ref.watch(plansProvider.notifier);

  //for creating simple Textfields for new plans
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //this gives me the List<Plan>
    final List<Plan> plans = ref.watch(plansProvider);
    //_plans = ref.watch(plansProvider);
    print('plancreator build: $plans');
    //final plans = ref.watch(plansProvider);
    //next way with "notifier" can pick which state to get
    //final plans = ref.read(plansProvider.notifier).plans;

    return Scaffold(
      appBar: AppBar(title: Text('Master Plans')),
      body: Column(
        children: <Widget>[
          _buildPlanCreator(), //textfield and func to add plan on tap
          Expanded(child: _buildMasterPlans()),
        ],
      ),
    );
  }

  Widget _buildPlanCreator() {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          //makes field pop out
          color: Theme.of(context).cardColor,
          elevation: 10,
          child: TextField(
              controller: textController,
              decoration: InputDecoration(
                  labelText: 'Add a Plan', contentPadding: EdgeInsets.all(20)),
              onEditingComplete: addPlan),
        ));
  }

  ///check if user typed something into field and reset screen
  void addPlan() {
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

    planController.addNewPlan(text);
    //instance of PlanController
    print('plancreator addPlan: $planController');
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
  Widget _buildMasterPlans() {
    //final plans = ref.read(plansProvider.notifier).plans;

    final plans = ref.watch(plansProvider.notifier).plans;

    if (plans.isEmpty) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.note, size: 100, color: Colors.grey),
            Text('No plans yet', style: Theme.of(context).textTheme.headline5)
          ]);
    }

    return ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          final plan = plans[index];
          return ListTile(
              title: Text(plan.name),
              subtitle: Text(plan.completenessMessage),
              onTap: () {
                //go  to plan_screen for this plan
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => PlanScreen(
                          plan: plan,
                          planName: plan.name,
                        )));
              });
        });
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
