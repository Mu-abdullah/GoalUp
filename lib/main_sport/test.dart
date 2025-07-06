// class PlayerRatingScreen extends StatefulWidget {
//   final String playerId;
//   const PlayerRatingScreen({super.key, required this.playerId});

//   @override
//   State<PlayerRatingScreen> createState() => _PlayerRatingScreenState();
// }

// class _PlayerRatingScreenState extends State<PlayerRatingScreen> {
//   late Future<void> futureData;
//   List<CategoryModel> categories = [];
//   Map<int, List<CriteriaModel>> criteriaPerCategory = {}; // category_id → List<criteria>
//   Map<int, TextEditingController> scoreControllers = {};   // criteria_id → controller

//   final PageController pageController = PageController();

//   @override
//   void initState() {
//     super.initState();
//     futureData = fetchData();
//   }

//   Future<void> fetchData() async {
//     final supabase = Supabase.instance.client;

//     final categoryRes = await supabase.from('categories').select();
//     final criteriaRes = await supabase.from('criteria').select();

//     categories = (categoryRes as List)
//         .map((e) => CategoryModel.fromJson(e))
//         .toList();

//     final allCriteria = (criteriaRes as List)
//         .map((e) => CriteriaModel.fromJson(e))
//         .toList();

//     for (final cat in categories) {
//       criteriaPerCategory[cat.id] =
//           allCriteria.where((c) => c.categoryId == cat.id).toList();
//     }

//     for (var crit in allCriteria) {
//       scoreControllers[crit.id] = TextEditingController();
//     }
//   }

//   Future<void> submitScores() async {
//     final supabase = Supabase.instance.client;
//     final List<Map<String, dynamic>> evaluations = [];

//     scoreControllers.forEach((criteriaId, controller) {
//       final text = controller.text;
//       if (text.isNotEmpty) {
//         final score = int.tryParse(text);
//         if (score != null) {
//           evaluations.add({
//             'player_id': widget.playerId,
//             'criteria_id': criteriaId,
//             'player_score': score,
//           });
//         }
//       }
//     });

//     if (evaluations.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("No scores entered")),
//       );
//       return;
//     }

//     for (final eval in evaluations) {
//       await supabase.from('evaluations').insert(eval);
//     }

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Evaluations submitted!")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Player Rating")),
//       body: FutureBuilder(
//         future: futureData,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState != ConnectionState.done) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return Column(
//             children: [
//               Expanded(
//                 child: PageView.builder(
//                   controller: pageController,
//                   itemCount: categories.length,
//                   itemBuilder: (context, index) {
//                     final category = categories[index];
//                     final criteria = criteriaPerCategory[category.id] ?? [];

//                     return Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: ListView(
//                         children: [
//                           Text(
//                             category.name,
//                             style: Theme.of(context).textTheme.headline6,
//                           ),
//                           const SizedBox(height: 16),
//                           ...criteria.map((crit) {
//                             return Padding(
//                               padding: const EdgeInsets.only(bottom: 12.0),
//                               child: TextFormField(
//                                 controller: scoreControllers[crit.id],
//                                 keyboardType: TextInputType.number,
//                                 decoration: InputDecoration(
//                                   labelText: crit.name,
//                                   border: const OutlineInputBorder(),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       pageController.previousPage(
//                         duration: const Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                       );
//                     },
//                     child: const Text("Previous"),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       pageController.nextPage(
//                         duration: const Duration(milliseconds: 300),
//                         curve: Curves.easeInOut,
//                       );
//                     },
//                     child: const Text("Next"),
//                   ),
//                   ElevatedButton(
//                     onPressed: submitScores,
//                     child: const Text("Submit"),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
