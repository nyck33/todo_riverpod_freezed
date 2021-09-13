# master_plan

FastAPIのバックエンドはこちらです：https://github.com/nyck33/masterplan_fastapi_postgres
テスト用にHerokuにデプロイしました：https://todo-fastapi-flutter.herokuapp.com/plan
/planのパスにPostリクエスト（BodyがClass PlanのJson）

### シンプルですが、FreezedとRiverpodの機能を導入しまして、正常に実行できます。

###　残っている課題：
１．SharedPreferences及びその他の方法にてデータをセーブする。現状ユーザーがアプリを離れますと、例としてAndroidホームスクリーンに一旦戻る、アプリの状態が最初に起動した状態にリセットされます。Riverpodの作者がこの機能は「今後追加するかもしれない」と教えてくれました：https://github.com/rrousselGit/river_pod/issues/735#issuecomment-917448464

２．FastAPIが受信してからPostgresにアップロードする。

３．Http.get、Postgresからデータを引き出す方はまだ書いてません。

###　今後追加予定の機能は以下です：

１．カレンダー機能
２．削除機能
３．ログイン機能


