part of 'pages.dart';

class SuccessPage extends StatelessWidget {
  final Ticket ticket;
  final FlutixTransaction transaction;

  SuccessPage(this.ticket, this.transaction);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return;
      },
      child: Scaffold(
        body: FutureBuilder(
          future: ticket != null
              ? processingTicketOrder(context)
              : processingTopUp(context),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.only(bottom: 70),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ticket == null
                            ? "assets/top_up_done.png"
                            : "assets/ticket_done.png"),
                      ),
                    ),
                  ),
                  Text(
                    ticket == null ? "Emm Yummy" : "Happy Watching",
                    style: blackTextFont.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Container(
                    height: 45,
                    width: 250,
                    margin: EdgeInsets.only(top: 70, bottom: 20),
                    child: RaisedButton(
                        elevation: 0,
                        color: mainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(ticket == null ? "My Wallet" : "My Ticket",
                            style: whiteTextFont.copyWith(fontSize: 16)),
                        onPressed: () {
                          if (ticket == null) {
                            context
                                .bloc<PageBloc>()
                                .add(GoToWalletPage(GoToMainPage()));
                          } else {
                            // goto ticket
                          }
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Discover new movie ? ",
                          style: greyTextFont.copyWith(
                              fontWeight: FontWeight.w400)),
                      GestureDetector(
                          onTap: () {
                            context.bloc<PageBloc>().add(GoToMainPage());
                          },
                          child: Text("Back To Home", style: purpleTextFont))
                    ],
                  )
                ],
              );
            } else {
              return Center(
                  child: SpinKitFadingCircle(color: mainColor, size: 50));
            }
          },
        ),
      ),
    );
  }

  Future<void> processingTicketOrder(BuildContext context) async {
    context.bloc<UserBloc>().add(Purchase(ticket.totalPrice));
    context.bloc<TicketBloc>().add(BuyTickets(ticket, transaction.userID));

    await FlutixTransactionServices.saveTransaction(transaction);
  }

  Future<void> processingTopUp(BuildContext context) async {
    context.bloc<UserBloc>().add(TopUp(transaction.amount));

    await FlutixTransactionServices.saveTransaction(transaction);
  }
}
