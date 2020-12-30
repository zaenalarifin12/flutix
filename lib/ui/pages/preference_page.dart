part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final List<String> genres = [
    "Horror",
    "Music",
    "Action",
    "Drama",
    "War",
    "Crime"
  ];

  final List<String> languages = ["Bahasa", "English", "Japanese", "Korean"];

  final RegistrationData registrationData;

  PreferencePage(this.registrationData);

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  List<String> selectedGenres = [];
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.registrationData.password = "";

        context
            .bloc<PageBloc>()
            .add(GoToRegistrationPage(widget.registrationData));
        return;
      },
      child: Scaffold(
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 56,
                      margin: EdgeInsets.only(top: 20, bottom: 4),
                      child: GestureDetector(
                        onTap: () async {
                          widget.registrationData.password = "";

                          context.bloc<PageBloc>().add(
                              GoToRegistrationPage(widget.registrationData));
                        },
                        child: Icon(Icons.arrow_forward),
                      ),
                    )
                  ],
                ),
                Text(
                  "Select your four\n Favorite Genres",
                  style: blackTextFont.copyWith(fontSize: 20),
                ),
                SizedBox(
                  height: 16,
                ),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: generateGenreWidget(context),
                ),
                SizedBox(
                  height: 16,
                ),
                Text("Movie Language\nYou Prefer",
                    style: blackTextFont.copyWith(fontSize: 20)),
                SizedBox(
                  height: 16,
                ),
                Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: generateLangWidget(context),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: mainColor,
                      child: Icon(Icons.arrow_forward),
                      onPressed: () {
                        if (selectedGenres.length != 4) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: "Please select 4 genre",
                          )..show(context);
                        } else {
                          widget.registrationData.selectedGenres =
                              selectedGenres;
                          widget.registrationData.selectedLanguage =
                              selectedLanguage;

                          context.bloc<PageBloc>().add(
                              GoToAccountConfirmationPage(
                                  widget.registrationData));
                        }
                      }),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            )),
      ),
    );
  }

  List<Widget> generateGenreWidget(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.genres
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedGenres.contains(e),
              onTap: () {
                onSelectGenre(e);
              },
            ))
        .toList();
  }

  List<Widget> generateLangWidget(BuildContext context) {
    double width =
        (MediaQuery.of(context).size.width - 2 * defaultMargin - 24) / 2;

    return widget.languages
        .map((e) => SelectableBox(
              e,
              width: width,
              isSelected: selectedLanguage == e,
              onTap: () {
                setState(() {
                  selectedLanguage = e;
                });
              },
            ))
        .toList();
  }

  void onSelectGenre(String genre) {
    if (selectedGenres.contains(genre)) {
      setState(() {
        selectedGenres.remove(genre);
      });
    } else {
      if (selectedGenres.length < 4) {
        setState(() {
          selectedGenres.add(genre);
        });
      }
    }
  }
}