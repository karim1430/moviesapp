import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:moviesapp/constants.dart';
import 'package:moviesapp/core/utils/app_style.dart';
import 'package:moviesapp/core/widgets/louding_indicator.dart';
import 'package:moviesapp/core/widgets/movies_failure_wigets.dart';
import 'package:moviesapp/feature/movies/data/models/movies_detail_model.dart';
import 'package:moviesapp/feature/movies/presentation/manage/movies_detail/movies_detail_cubit.dart';
import 'package:moviesapp/feature/movies/presentation/views/widgets/buttom_navigation_bar.dart';

import 'package:moviesapp/feature/movies/presentation/views/widgets/cast_movies_list_view.dart';
import 'package:moviesapp/feature/movies/presentation/views/widgets/details_movies.dart';
import 'package:moviesapp/feature/movies/presentation/views/widgets/header_movies_details.dart';

import 'package:moviesapp/feature/movies/presentation/views/widgets/reviews_list_view.dart';
import 'package:moviesapp/feature/movies/presentation/views/widgets/similar_moviews_list_view.dart';
import 'package:moviesapp/feature/watchlist/presentation/manage/watchlist_cubit/watch_cubit.dart';

import '../../../../../core/utils/api_constant.dart';

class MoviesDetailsViewBody extends StatelessWidget {
  const MoviesDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return BlocBuilder<MoviesDetailCubit, MoviesDetailState>(
      builder: (context, state) {
        if (state is MoviesDetailSuccess) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: SafeArea(
                  child: Container(
                    width: width,
                    height: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            '${ApiConstants.basePosterUrl}${state.moviesDetailModel.posterPath}'),
                        fit: BoxFit.fill,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.8), // Shadow color
                          spreadRadius: 0, // How wide the shadow spreads
                          blurRadius: 8, // Softness of the shadow
                          offset: const Offset(0,
                              8), // Position of the shadow (horizontal, vertical)
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderMoviesDetails(
                          moviesDetailModel: state.moviesDetailModel,
                        ),
                        const Expanded(child: SizedBox()),
                        DetailsMovies(
                          moviesDetailModel: state.moviesDetailModel,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Story',
                    style: AppStyle.styleSemiBold24(context),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    state.moviesDetailModel.overview ?? '',
                    style: AppStyle.styleSemiBold18(context),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Cast',
                    style: AppStyle.styleSemiBold24(context),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: CastMoviesListView(
                  moviesDetailModel: state.moviesDetailModel,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Reviews',
                    style: AppStyle.styleSemiBold24(context),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: ReviewsListView(
                  moviesDetailModel: state.moviesDetailModel,
                ),
              )),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'Similar',
                    style: AppStyle.styleSemiBold24(context),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.only(left: 7),
                child: SimilarMoviesListView(
                  moviesDetailModel: state.moviesDetailModel,
                ),
              )),
              const SliverToBoxAdapter(child: BottomNavigationBarWidget())
            ],
          );
        } else if (state is MoviesDetailFailure) {
          return MoviesFailureWigets(errMessage: state.errMessage);
        } else {
          return const LoudingIndicatorWidget();
        }
      },
    );
  }
}

// class HeaderMoviesDetailsWidget extends StatelessWidget {
//   const HeaderMoviesDetailsWidget({
//     super.key,
//     required this.moviesDetailModel,
//   });
//   final MoviesDetailModel moviesDetailModel;
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<WatchCubit, WatchState>(
//       builder: (context, state) {
//         if (state is WatchSuccess) {
//           return HeaderMoviesDetails(
//             moviesDetailModel: moviesDetailModel,
//           );
//         } else if (state is WatchFailure) {
//           log(state.errMessage);
//         } else {
//           return ;
//         }
//       },
//     );
//   }
// }




















// import 'package:flutter/material.dart';

// class StarRating extends StatelessWidget {
//   final int rating;
//   final int maxRating;
//   final Color color;

//   StarRating({
//     required this.rating,
//     this.maxRating = 5,
//     this.color = Colors.amber,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: List.generate(maxRating, (index) {
//         return Icon(
//           index < rating ? Icons.star : Icons.star_border,
//           color: color,
//         );
//       }),
//     );
//   }
// }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Colors.grey[900],
//         body: Center(
//           child: StarRating(rating: 4),
//         ),
//       ),
//     );
//   }
// }
