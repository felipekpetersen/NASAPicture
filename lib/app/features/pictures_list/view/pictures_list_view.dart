import 'package:flutter/cupertino.dart';
import 'package:nasa_pictures/app/features/pictures_list/view_model/pictures_list_view_model.dart';

class PicturesListView extends StatefulWidget {
  const PicturesListView({super.key, required this.viewModel});
  final PicturesListViewModel viewModel;

  @override
  State<PicturesListView> createState() => _PicturesListViewState();
}

class _PicturesListViewState extends State<PicturesListView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
