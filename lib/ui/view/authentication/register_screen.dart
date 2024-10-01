
import 'package:bloc_api/core/bloc/stream_bloc/stream_bloc.dart';
import 'package:bloc_api/core/bloc/subject_bloc/subject_bloc.dart';
import 'package:bloc_api/ui/view/authentication/email_verify_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/bloc/address/city_bloc/city_bloc.dart';
import '../../../core/bloc/address/country_bloc/country_bloc.dart';
import '../../../core/bloc/address/state_bloc/state_bloc.dart';
import '../../../core/bloc/auth/register_bloc/register_bloc.dart';
import '../../widget/common_button.dart';
import '../../widget/common_snackbar.dart';
import '../../widget/common_textfield.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _registerKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var mobileController = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  var universityController = TextEditingController();
  var collegeController = TextEditingController();
  var languageController = TextEditingController();
  var otherController = TextEditingController();
  var streamController = TextEditingController();
  var subjectsController = TextEditingController();
  final bool _obSecure = true;

  int countryValue = 0;
  int stateValue = 0;
  int cityValue = 0;
  String? streamValue;
  String? subjectValue;
  bool checkboxValue = false;

  ValueNotifier<bool> submitBtnLoader = ValueNotifier(false);

  @override
  void initState() {
    callApi();
    super.initState();
  }

  callApi() {
    ///getCountries
    BlocProvider.of<CountryBloc>(context).add(const UserCountryEvent(
        url: "http://theguruchela.sumayinfotech.com/api/countries"));

    ///getStates
    if (countryValue != 0) {
      BlocProvider.of<StateBloc>(context).add(UserStateEvent(
        url: "http://theguruchela.sumayinfotech.com/api/states",
        countryId: countryValue.toString(),
      ));
    }

    ///getCities
    if (stateValue != 0) {
      BlocProvider.of<CityBloc>(context).add(UserCityEvent(
        url: "http://theguruchela.sumayinfotech.com/api/cities",
        stateId: stateValue.toString(),
      ));
    }

    ///getStreams
    BlocProvider.of<StreamBloc>(context).add(const UserStreamEvent(
      url: "http://theguruchela.sumayinfotech.com/api/streams",
    ));

    ///getSubjects
    if (streamValue != null) {
      BlocProvider.of<SubjectBloc>(context).add(UserSubjectEvent(
        url: "http://theguruchela.sumayinfotech.com/api/subjects",
        uuid: streamValue.toString(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(7),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFFf2f4f6),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        title: const Text(
          "Register",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const SizedBox(
                  height: 10,
                ),
                _registerFrom(),
                BlocListener<RegisterScreenBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      submitBtnLoader.value = false;
                      Get.to(EmailVerifiedScreen(
                          email: emailController.text, isSignUp: true));
                      showSnackBar(
                          context: context,
                          isError: false,
                          message: state.registerModel.message ?? "");
                    } else if (state is RegisterFailed) {
                      submitBtnLoader.value = false;
                      showSnackBar(
                          context: context,
                          isError: true,
                          message: state.error);
                    }
                  },
                  child: ValueListenableBuilder(
                      valueListenable: submitBtnLoader,
                      builder: (context, value, child) {
                        return CustomBtn(
                          loading: value,
                          name: "Sign Up",
                          borderColor: Colors.black,
                          textColor: Colors.white,
                          btnColor: Colors.blueGrey,
                          onTap: () {
                            BlocProvider.of<RegisterScreenBloc>(context).add(
                                UserSignUpEvent(
                                    url:
                                        "http://theguruchela.sumayinfotech.com/api/student-register",
                                    body: {
                                  "email": emailController.text,
                                  "password": passwordController.text,
                                  "name": nameController.text,
                                  "mobile": mobileController.text,
                                  "university_name": universityController.text,
                                  "college_name": collegeController.text,
                                  "preferred_language": languageController.text,
                                  "other_information": otherController.text,
                                  "country": countryValue.toString(),
                                  "state": stateValue.toString(),
                                  "city": cityValue.toString(),
                                  "stream_uuid": streamValue.toString(),
                                  "subjects": subjectValue.toString(),
                                  "access_token": "123456",
                                }));
                          },
                        );
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    //Get.to(const RegisterScreen());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text('have an account? Sign In',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerFrom() {
    return Form(
      key: _registerKey,
      child: Column(
        children: [
          //Name
          CustomField(
            controller: nameController,
            hint: "Name",
            autofillHints: const [AutofillHints.name],
            keyboardType: TextInputType.name,
            isBottomSpace: true,
          ),

          //Email
          CustomField(
            controller: emailController,
            hint: "Email",
            autofillHints: const [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
            isBottomSpace: true,
          ),

          //Mobile
          CustomField(
            controller: mobileController,
            hint: "Mobile No",
            autofillHints: const [AutofillHints.telephoneNumber],
            keyboardType: TextInputType.phone,
            isBottomSpace: true,
          ),

          //Country
          CustomField(
            controller: countryController,
            hint: "Country",
            autofillHints: const [AutofillHints.countryName],
            keyboardType: TextInputType.text,
            readOnly: true,
            onTap: () {
              countryBottomSheet(context);
            },
            isBottomSpace: true,
          ),
          //State
          CustomField(
            controller: stateController,
            hint: "State",
            autofillHints: const [AutofillHints.countryName],
            keyboardType: TextInputType.text,
            readOnly: true,
            onTap: () {
              callApi();
              stateBottomSheet(context);
            },
            isBottomSpace: true,
          ),
          //City
          CustomField(
            controller: cityController,
            hint: "City",
            autofillHints: const [AutofillHints.countryName],
            keyboardType: TextInputType.text,
            isBottomSpace: true,
            readOnly: true,
            onTap: () {
              callApi();
              cityBottomSheet();
            },
          ),

          //University
          CustomField(
            controller: universityController,
            hint: "University",
            autofillHints: const [AutofillHints.postalAddress],
            keyboardType: TextInputType.text,
            isBottomSpace: true,
          ),

          //College
          CustomField(
            controller: collegeController,
            hint: "College",
            autofillHints: const [AutofillHints.postalAddress],
            keyboardType: TextInputType.text,
            isBottomSpace: true,
          ),

          //Language
          CustomField(
            controller: languageController,
            hint: "Preferred Language",
            autofillHints: const [AutofillHints.language],
            keyboardType: TextInputType.text,
            isBottomSpace: true,
          ),

          //Other info
          CustomField(
            controller: otherController,
            hint: "Other Info",
            autofillHints: const [AutofillHints.name],
            keyboardType: TextInputType.text,
            isBottomSpace: true,
          ),

          //Stream
          CustomField(
            controller: streamController,
            hint: "Stream",
            autofillHints: const [AutofillHints.postalAddress],
            keyboardType: TextInputType.text,
            isBottomSpace: true,
            readOnly: true,
            onTap: () {
              streamsBottomSheet();
            },
          ),

          //subject
          CustomField(
            controller: subjectsController,
            hint: "Subject",
            autofillHints: const [AutofillHints.postalAddress],
            keyboardType: TextInputType.text,
            isBottomSpace: true,
            readOnly: true,
            onTap: () {
              subjectBottomSheet();
            },
          ),

          //password
          CustomField(
            controller: passwordController,
            hint: "Password",
            obscureText: _obSecure,
            autofillHints: const [AutofillHints.password],
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }

  countryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Country",
                        style: TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 5),
                Expanded(
                  child: BlocBuilder<CountryBloc, CountryState>(
                    builder: (context, state) {
                      if (state is CountryLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CountrySuccess) {
                        return ListView.builder(
                          itemCount: state.country.data!.length,
                          itemBuilder: (context, index) {
                            final name = state.country.data![index].name ?? "";
                            final id = state.country.data![index].id ?? 0;
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(name),
                                  onTap: () {
                                    countryController.text = name;
                                    countryValue = id;
                                    callApi();
                                    Navigator.pop(context);
                                  },
                                ),
                                const Divider(height: 1),
                              ],
                            );
                          },
                        );
                      } else if (state is CountryFailed) {
                        return showSnackBar(
                          isError: true,
                          message: state.error,
                          context: context,
                        );
                      } else {
                        return const Center(child: Text("No data found"));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  stateBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "State",
                        style: TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 5,
                  color: Colors.black,
                ),
                Expanded(
                  child: BlocBuilder<StateBloc, StateState>(
                    builder: (context, state) {
                      if (state is StateLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is StateSuccess) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.states.data!.length,
                          itemBuilder: (context, index) {
                            final name = state.states.data![index].name ?? "";
                            final id = state.states.data![index].id ?? 0;
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(name),
                                  onTap: () {
                                    stateController.text = name;
                                    stateValue = id;
                                    callApi();
                                    Navigator.pop(context);
                                  },
                                ),
                                const Divider(height: 1),
                              ],
                            );
                          },
                        );
                      } else if (state is StateFailed) {
                        return const Text("Failed");
                      } else {
                        if (countryValue == 0) {
                          return const Center(
                              child: Text("Please select Country First!"));
                        }
                        return const Text("No Data Found");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  cityBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "City",
                        style: TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 5,
                  color: Colors.black,
                ),
                Expanded(
                  child: BlocBuilder<CityBloc, CityState>(
                    builder: (context, state) {
                      if (state is CityLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is CitySuccess) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.cityModel.data!.length,
                          itemBuilder: (context, index) {
                            final name =
                                state.cityModel.data![index].name ?? "";
                            final id = state.cityModel.data![index].id ?? 0;
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(name),
                                  onTap: () {
                                    cityController.text = name;
                                    cityValue = id;
                                    Navigator.pop(context);
                                  },
                                ),
                                const Divider(height: 1),
                              ],
                            );
                          },
                        );
                      } else if (state is CityFailed) {
                        return const Text("Failed");
                      } else {
                        if (stateValue == 0) {
                          return const Center(
                              child: Text("Please select State First!"));
                        }
                        return const Text("No Data Found");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  streamsBottomSheet() {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      elevation: 4,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Stream",
                        style: TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 5,
                  color: Colors.black,
                ),
                Expanded(
                  child: BlocBuilder<StreamBloc, StreamState>(
                    builder: (context, state) {
                      if (state is StreamLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is StreamSuccess) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.streamData.data!.length,
                          itemBuilder: (context, index) {
                            final name =
                                state.streamData.data![index].title ?? "";
                            final id = state.streamData.data![index].uuid ?? 0;
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(name),
                                  onTap: () {
                                    streamController.text = name;
                                    streamValue = id.toString();
                                    callApi();
                                    Navigator.pop(context);
                                  },
                                ),
                                const Divider(height: 1),
                              ],
                            );
                          },
                        );
                      } else if (state is StateFailed) {
                        return const Text("Failed");
                      } else {
                        return const Text("noDataFound");
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  subjectBottomSheet() {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Subjects",
                        style: TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 5,
                  color: Colors.black,
                ),
                Expanded(
                  child: BlocBuilder<SubjectBloc, SubjectState>(
                    builder: (context, state) {
                      if (state is SubjectLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SubjectSuccess) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.subject.data!.length,
                          itemBuilder: (context, index) {
                            final name = state.subject.data![index].title ?? "";
                            final id = state.subject.data![index].uuid ?? 0;
                            return Column(
                              children: [
                                ListTile(
                                  title: Text(name),
                                  onTap: () {
                                    subjectsController.text = name;
                                    subjectValue = id.toString();
                                    Navigator.pop(context);
                                  },
                                ),
                                const Divider(height: 1),
                              ],
                            );
                          },
                        );
                      } else if (state is SubjectFailed) {
                        return const Text("Failed");
                      } else {
                        if (streamValue == null) {
                          return const Center(
                              child: Text("Please select Stream First!"));
                        }
                        return const Text("noDataFound");
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
