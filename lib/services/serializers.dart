import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/serializer.dart';

import '../models/plan.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Plan,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
