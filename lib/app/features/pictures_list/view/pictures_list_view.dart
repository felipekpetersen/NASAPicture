import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
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
        appBar: AppBar(
          title: const Text('Nasa Pictures'),
        ),
        body: Column(
          children: [
            search,
            widget.viewModel.isLoading
                ? loadingScreen
                : widget.viewModel.noResultsSearch
                    ? noResultsSearch
                    : Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.viewModel.pictures.length,
                            itemBuilder: (context, index) {
                              return item(widget.viewModel.pictures[index]);
                            }),
                      )
          ],
        ));
  }

  Widget get search => Container(
        color: Colors.black12,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        width: MediaQuery.of(context).size.width,
        child: TextField(
          decoration: const InputDecoration.collapsed(hintText: 'Search'),
          controller: widget.viewModel.searchController,
          onChanged: (value) => widget.viewModel.onSearch(value),
        ),
      );

  Widget get loadingScreen => Center(
        child: Container(
          height: 50,
          width: 50,
          child: const CircularProgressIndicator(),
        ),
      );

  Widget get noResultsSearch => Center(
        child: Text("No pictures found"),
      );

  Widget item(PictureResponseModel item) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => widget.viewModel.onTapPicture(item),
      child: Row(
        children: [
          CachedImage(url: item.url ?? "", height: 100, width: 100),
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
