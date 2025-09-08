import 'package:flutter/material.dart';
import 'package:ostudy/data/services/api/user/mentor_services.dart';
import 'package:ostudy/data/services/model/mentor_model.dart';
import 'package:ostudy/presentation/core/components/avatar.dart';
import 'package:ostudy/presentation/core/components/page_title.dart';
import 'package:ostudy/presentation/core/utils/app_textstyles.dart';

class ListMentor extends StatefulWidget {
  const ListMentor({super.key});

  @override
  State<ListMentor> createState() => _ListMentorState();
}

class _ListMentorState extends State<ListMentor> {
  final MentorServices _mentorServices = MentorServices();

  late Future<List<MentorModel>> _mentors;

  @override
  void initState() {
    super.initState();
    _mentors = _mentorServices.getAllMentors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: [
            CustomPageTitle(
              title: "Our Mentor",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 32),
            Expanded(
              child: FutureBuilder<List<MentorModel>>(
                future: _mentors,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No mentors found"));
                  }

                  final mentors = snapshot.data!;

                  return ListView.builder(
                    itemCount: mentors.length,
                    itemBuilder: (context, index) {
                      final mentor = mentors[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const AvatarProfile(isEditable: false),
                            Column(
                              children: [
                                Text(mentor.name,
                                    style: ParagraphBody.smallBold),
                                Text(
                                  mentor.role,
                                  style: ParagraphBody.xsmallRegular,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
