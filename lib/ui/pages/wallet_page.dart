part of 'pages.dart';

class WalletPage extends StatelessWidget {
  final PageEvent pageEvent;

  WalletPage(this.pageEvent);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<PageBloc>().add(pageEvent);

        return;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(color: accentColor2),
            SafeArea(child: Container(color: Colors.white)),
            // NOTE CONTENT
            SafeArea(
              child: Container(
                margin: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 0),
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: () {},
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        BlocBuilder<UserBloc, UserState>(
                            builder: (_, userState) {
                          return Column(
                            children: [
                              SizedBox(height: 20),
                              Text("My Wallet",
                                  style: blackTextFont.copyWith(fontSize: 20)),
                              Container(
                                width: double.infinity,
                                height: 185,
                                margin: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xFF382A74),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        spreadRadius: 0,
                                        offset: Offset(0, 5))
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    ClipPath(
                                        clipper: CardReflectionClipper(),
                                        child: Container(
                                            height: 185,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topLeft,
                                                    colors: [
                                                      Colors.white
                                                          .withOpacity(0.1),
                                                      Colors.white
                                                          .withOpacity(0)
                                                    ])))),
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                  width: 18,
                                                  height: 18,
                                                  margin:
                                                      EdgeInsets.only(right: 4),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          Color(0xFFFFF2CB))),
                                              Container(
                                                  width: 30,
                                                  height: 30,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: accentColor2))
                                            ],
                                          ),
                                          Text(
                                              NumberFormat.currency(
                                                      locale: "id_ID",
                                                      symbol: "IDR",
                                                      decimalDigits: 0)
                                                  .format(
                                                      (userState as UserLoaded)
                                                          .user
                                                          .balance),
                                              style: whiteNumberFont.copyWith(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.w600)),
                                          Row(children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Card Holder",
                                                    style:
                                                        whiteTextFont.copyWith(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w300)),
                                                Row(
                                                  children: [
                                                    Text((userState
                                                            as UserLoaded)
                                                        .user
                                                        .name),
                                                    SizedBox(width: 4),
                                                    SizedBox(
                                                        height: 14,
                                                        width: 14,
                                                        child: Image.asset(
                                                            "assets/ic_check.png"))
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(width: 30),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Card ID",
                                                  style: whiteTextFont.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                        (userState
                                                                as UserLoaded)
                                                            .user
                                                            .id
                                                            .substring(0, 10)
                                                            .toLowerCase(),
                                                        style: whiteNumberFont
                                                            .copyWith(
                                                                fontSize: 12)),
                                                    SizedBox(width: 4),
                                                    SizedBox(
                                                        height: 14,
                                                        width: 14,
                                                        child: Image.asset(
                                                            "assets/ic_check.png"))
                                                  ],
                                                )
                                              ],
                                            )
                                          ])
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Recent Transaction",
                                  style: blackTextFont,
                                ),
                              ),
                              SizedBox(height: 12),
                              FutureBuilder(
                                future:
                                    FlutixTransactionServices.getTransaction(
                                  (userState as UserLoaded).user.id,
                                ),
                                builder: (_, snapshot) {
                                  if (snapshot.hasData) {
                                    return generateTransactionList(
                                        snapshot.data,
                                        MediaQuery.of(context).size.width -
                                            2 * defaultMargin);
                                  } else {
                                    return SpinKitFadingCircle(
                                        size: 50, color: mainColor);
                                  }
                                },
                              ),
                            ],
                          );
                        })
                      ],
                    )
                  ],
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: 250,
                    height: 46,
                    margin: EdgeInsets.only(bottom: 30),
                    child: RaisedButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: mainColor,
                      child: Text(
                        "Top Up My Wallet",
                        style: whiteTextFont.copyWith(fontSize: 16),
                      ),
                      onPressed: () {
                        context
                            .bloc<PageBloc>()
                            .add(GoToTopUpPage(GoToWalletPage(pageEvent)));
                      },
                    )))
          ],
        ),
      ),
    );
  }

  Column generateTransactionList(
      List<FlutixTransaction> transaction, double width) {
    transaction.sort((transaction1, transaction2) =>
        transaction2.time.compareTo(transaction1.time));

    return Column(
        children: transaction
            .map((e) => Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: TransactionCard(e, width),
                ))
            .toList());
  }
}

class CardReflectionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 15);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
