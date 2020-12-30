import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutix/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutix/services/services.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  @override
  TicketState get initialState => TicketState([]);

  @override
  Stream<TicketState> mapEventToState(
    TicketEvent event,
  ) async* {
    if (event is BuyTickets) {
      await TicketServices.saveTicket(event.userID, event.ticket);

      List<Ticket> tickets = state.tickets + [event.ticket];
 
      yield TicketState(tickets);
    } else if (event is GetTickets){
      List<Ticket> tickets =  await TicketServices.getTicket(event.userID);

      yield TicketState(tickets);
    }
  }
}
