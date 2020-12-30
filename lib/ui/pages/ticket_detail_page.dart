part of 'pages.dart';

class TicketDetailPage extends StatefulWidget {
  final Ticket ticket;

  TicketDetailPage(this.ticket);
  @override
  _TicketDetailPageState createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        context.bloc<PageBloc>().add(GoToMainPage(
            bottomNavBarIndex: 1,
            isExpired: widget.ticket.time.isBefore(DateTime.now())));

        return;
      },
      child: Scaffold(
        backgroundColor: Color(0xFFF6F7F9),
        body: Container(
          padding: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 0),
          child: ListView(
            children: [
              Column(
                children: [
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                            onTap: () {
                              context.bloc<PageBloc>().add(GoToMainPage(
                                  bottomNavBarIndex: 1,
                                  isExpired: widget.ticket.time
                                      .isBefore(DateTime.now())));
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black)),
                      ),
                      Center(
                        child: Text(
                          "Ticket Details",
                          style: blackTextFont.copyWith(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 170,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              imageBaseURL +
                                  "w500" +
                                  widget.ticket.movieDetail.backdropPath,
                            ),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                  ),
                  ClipPath(
                    clipper: TicketTopClipper(),
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.ticket.movieDetail.title,
                              maxLines: 2,
                              overflow: TextOverflow.clip,
                              style: blackTextFont.copyWith(fontSize: 18)),
                          SizedBox(height: 6),
                          Text(widget.ticket.movieDetail.genreAndLanguage,
                              style: greyTextFont.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w400)),
                          SizedBox(height: 6),
                          RatingStars(
                            voteAverage: widget.ticket.movieDetail.voteAverage,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Cinema",
                                style: greyTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                  widget.ticket.theater.name,
                                  textAlign: TextAlign.end,
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 9),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Date & Time",
                                  style: greyTextFont.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                              Text(widget.ticket.time.dateAndTime,
                                  style: whiteNumberFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Seat Number",
                                style: greyTextFont.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Text(widget.ticket.seatsInString,
                                      textAlign: TextAlign.end,
                                      style: whiteNumberFont.copyWith(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400)))
                            ],
                          ),
                          SizedBox(height: 9),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order ID",
                                style: greyTextFont.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(widget.ticket.bookingCode,
                                  style: whiteTextFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                          SizedBox(height: 20),
                          generateDashedDivider(
                              MediaQuery.of(context).size.width -
                                  2 * defaultMargin -
                                  40)
                        ],
                      ),
                    ),
                  ),
                  ClipPath(
                      clipper: TicketBottomClipper(),
                      child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(20, 16, 20, 16),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Name : ",
                                        style: greyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    Text(widget.ticket.name,
                                        style: whiteNumberFont.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(height: 8),
                                    Text("Paid: ",
                                        style: greyTextFont.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400)),
                                    Text(
                                        NumberFormat.currency(
                                                locale: "id_ID",
                                                decimalDigits: 0,
                                                symbol: "IDR ")
                                            .format(widget.ticket.totalPrice),
                                        style: whiteNumberFont.copyWith(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400))
                                  ]),
                              QrImage(
                                  version: 6,
                                  foregroundColor: Colors.black,
                                  errorCorrectionLevel: QrErrorCorrectLevel.M,
                                  padding: EdgeInsets.all(0),
                                  size: 100,
                                  data: widget.ticket.bookingCode)
                            ],
                          ))),
                  SizedBox(height: 50)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TicketTopClipper extends CustomClipper<Path> {
  double radius = 15;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - radius);
    path.quadraticBezierTo(radius, size.height - radius, radius, size.height);
    path.lineTo(size.width - radius, size.height);
    path.quadraticBezierTo(size.width - radius, size.height - radius,
        size.width, size.height - radius);
    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TicketBottomClipper extends CustomClipper<Path> {
  double radius = 15;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, radius);
    path.quadraticBezierTo(size.width - radius, radius, size.width - radius, 0);
    path.lineTo(radius, 0);
    path.quadraticBezierTo(radius, radius, 0, radius);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
