part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrationData registrationData;

  AccountConfirmationPage(this.registrationData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .bloc<PageBloc>()
            .add(GoToPreferencePage(widget.registrationData));

        return;
      },
      child: Scaffold(
          body: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 90),
                        height: 56,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {
                                  context
                                      .bloc<PageBloc>()
                                      .add(GoToSplashPage());
                                },
                                child:
                                    Icon(Icons.arrow_back, color: Colors.black),
                              ),
                            ),
                            Center(
                              child: Text(
                                "Confirm New\nAccount",
                                style: blackTextFont.copyWith(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 150,
                        margin: EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image:
                                  (widget.registrationData.profileImage == null)
                                      ? AssetImage("assets/user_pic.png")
                                      : FileImage(
                                          widget.registrationData.profileImage),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Text(
                        "Welcome",
                        style: blackTextFont.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "${widget.registrationData.name}",
                        style: blackTextFont.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 110,
                      ),
                      (isSigningUp)
                          ? SpinKitFadingCircle(
                              color: Color(0xFF3E9D9D), size: 45)
                          : SizedBox(
                              width: 250,
                              height: 45,
                              child: RaisedButton(
                                  color: Color(0xFF3E9D9D),
                                  child: Text("Create My Account",
                                      style:
                                          whiteTextFont.copyWith(fontSize: 16)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  onPressed: () async {
                                    setState(() {
                                      isSigningUp = true;
                                    });

                                    imageFileToUpload =
                                        widget.registrationData.profileImage;

                                    SignInSignUpResult result =
                                        await AuthServices.signUp(
                                            widget.registrationData.email,
                                            widget.registrationData.password,
                                            widget.registrationData.name,
                                            widget.registrationData
                                                .selectedGenres,
                                            widget.registrationData
                                                .selectedLanguage);

                                    if (result.user == null) {
                                      setState(() {
                                        isSigningUp = false;
                                      });
                                    }
                                  }))
                    ],
                  )
                ],
              ))),
    );
  }
}
