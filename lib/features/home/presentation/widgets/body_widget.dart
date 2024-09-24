import 'package:clean_arch_bloc_chat_app/features/home/domain/entities/home_entity.dart';
import 'package:clean_arch_bloc_chat_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:clean_arch_bloc_chat_app/utils/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    print('inside body widget');
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return Container(
      decoration: BoxDecoration(
        color: theme().scaffoldBackgroundColor,
      ),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is HomeLoadedState || state is HomeSwitchTabState) {
            List<HomeEntity> navigationItems = [];
            Widget? content;

            if (state is HomeLoadedState) {
              navigationItems = state.homeNavigationItems;
            } else if (state is HomeSwitchTabState) {
              navigationItems = state.homeNavigationItems;
              content = state.itemWidget;
            }

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SearchBar(
                    elevation: WidgetStatePropertyAll(0),
                  ),
                  Expanded(
                    child: content ?? const Center(child: Text('Select a Tab')),
                  ),
                  SizedBox(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: navigationItems.length,
                      itemBuilder: (context, index) {
                        final homeNavigationItem = navigationItems[index];
                        return GestureDetector(
                          onTap: () {
                            homeBloc.add(HomeSwitchTabEvent(index: index));
                          },
                          child: Column(
                            children: [
                              // icon
                              homeNavigationItem.itemIcon,
                              // name
                              Text(homeNavigationItem.itemName),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          } else if (state is HomeErrorState) {
            return const Center(
              child: Text('Some Error Occured'),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
