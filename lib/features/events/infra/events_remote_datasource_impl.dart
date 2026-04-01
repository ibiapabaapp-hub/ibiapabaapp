import 'package:dio/dio.dart';
import 'package:ibiapabaapp/core/network/dio_exception_to_app_exception_mapper.dart';
import 'package:ibiapabaapp/features/events/data/datasources/events_remote_datasource.dart';
import 'package:ibiapabaapp/features/events/infra/models/event_model.dart';
import 'package:ibiapabaapp/features/events/domain/entities/event.dart';

class EventsRemoteDatasourceImpl implements EventsRemoteDatasource {
  final Dio dio;
  EventsRemoteDatasourceImpl(this.dio);

  @override
  Future<List<Event>> getAllEvents() async {
    try {
      final response = await dio.get('/events');
      return EventModel.fromJsonList(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }

  @override
  Future<Event> getEventById(String id) async {
    try {
      final response = await dio.get('/events/$id');
      return EventModel.fromJson(response.data);
    } on DioException catch (e) {
      throw DioExceptionToAppExceptionMapper.map(e);
    }
  }
}
