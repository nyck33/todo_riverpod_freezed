# master_plan

### 現時点でClass Plan内のList<Task>にTaskを追加する場面で迷ってます。Plan_Screen.dartのUIにてボタンプレスした時にPlanController.dartのファンクション　PlanController.createNewTask()を実行していますがエラーが発生します。思想としてはPlanController.createNewTaskがPlanControllerのメンバーのList<Plan>を新規のTaskを追加した新規のList<Plan>に更新することにより、「PlanController extends StateNotifier」ですが、PlanProvider.dartのProviderが更新に気づきまして、FlutterがUIを再構築する、でした。

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
