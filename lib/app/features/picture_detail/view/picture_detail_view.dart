import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nasa_pictures/app/utils/components/cached_image.dart';

import '../view_model/picture_detail_view_model.dart';

class PictureDetailView extends StatefulWidget {
  final PictureDetailViewModel viewModel;
  const PictureDetailView({super.key, required this.viewModel});

  @override
  State<PictureDetailView> createState() => _PictureDetailViewState();
}

class _PictureDetailViewState extends State<PictureDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(widget.viewModel.selectedPicture?.title ?? ''),
            const SizedBox(height: 16,),
            CachedImage(url: widget.viewModel.selectedPicture?.url ?? "", height: 200, width: MediaQuery.of(context).size.width),
            const SizedBox(height: 16,),
            Text(widget.viewModel.selectedPicture?.explanation ?? '')
          ],
        ),
      ),
    );
  }
}
