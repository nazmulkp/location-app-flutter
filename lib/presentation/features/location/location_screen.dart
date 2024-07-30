import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_app/presentation/features/location/bloc/location_bloc.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => LocationBloc(),
        child: LocationBody(),
      ),
    );
  }
}

class LocationBody extends StatelessWidget {
  LocationBody({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Screen'),
      ),
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is LocationLoaded) {
            _scrollToBottom();
          }
        },
        builder: (context, state) {
          if (state is LocationInitial) {
            return const Center(
              child: Text('Press the button to start tracking location.'),
            );
          } else if (state is LocationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LocationLoaded) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.locations.length,
                itemBuilder: (context, index) {
                  final location = state.locations[index];
                  return ListTile(
                    title:
                        Text('📍: ${location.latitude}, ${location.longitude}'),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          return FloatingActionButton(
            child:
                Icon(state is LocationInitial ? Icons.play_arrow : Icons.stop),
            onPressed: () {
              if (state is LocationInitial) {
                BlocProvider.of<LocationBloc>(context)
                    .add(StartLocationTracking());
              } else {
                BlocProvider.of<LocationBloc>(context)
                    .add(StopLocationTracking());
              }
            },
          );
        },
      ),
    );
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
