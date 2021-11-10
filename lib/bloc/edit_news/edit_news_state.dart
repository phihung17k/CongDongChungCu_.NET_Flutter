
import '../../models/news/news_model.dart';
import 'package:equatable/equatable.dart';

class EditNewsState extends Equatable{
NewsModel receiveModel;
final bool result;

EditNewsState({this.receiveModel, this.result});

EditNewsState copyWith({NewsModel receiveModel, bool result}){
  return EditNewsState(
      receiveModel: receiveModel ?? this.receiveModel,
      result: result ?? this.result
  );
}
  @override
  // TODO: implement props
  List<Object> get props => [receiveModel, result];
}