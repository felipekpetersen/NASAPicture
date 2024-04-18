import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nasa_pictures/app/data/model/picture_response_model.dart';
import 'package:nasa_pictures/app/features/pictures_list/view_model/pictures_list_view_model.dart';

import '../../../utils/components/cached_image.dart';

class PicturesListView extends StatefulWidget {
  const PicturesListView({super.key, required this.viewModel});
  final PicturesListViewModel viewModel;

  @override
  State<PicturesListView> createState() => _PicturesListViewState();
}

class _PicturesListViewState extends State<PicturesListView> {
  @override
  void initState() {
    SchedulerBinding.instance
        .addPostFrameCallback((timeStamp) => widget.viewModel.getPictures());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.viewModel.pictures.length,
          itemBuilder: (context, index) {
            return item(widget.viewModel.pictures[index]);
          }),
    );
  }

  Widget item(PictureResponseModel item) {
    return GestureDetector(
      onTap: () => widget.viewModel.onTapPicture(item),
      child: Row(
        children: [
          CachedImage(url: item.url ?? "", height: 50, width: 50),
          Flexible(
              child: Container(
            margin: const EdgeInsets.all(16),
            child: Text(item.title ?? ""),
          )),
        ],
      ),
    );
  }
}
