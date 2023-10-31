import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tinderlike/domain/bloc/modal_bloc/modal_bloc.dart';
import 'package:tinderlike/domain/bloc/modal_bloc/modal_events.dart';
import 'package:tinderlike/domain/bloc/modal_bloc/modal_states.dart';
import 'package:tinderlike/domain/data_provider/data_provider_users.dart';
import '../../../domain/bloc/home_bloc/home_bloc.dart';
import '../../../domain/bloc/home_bloc/home_events.dart';
import '../../../domain/bloc/home_bloc/home_states.dart';
import '../../../domain/entity/album.dart';
import 'features/bottom_buttons.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  PageController controller=PageController();
  late final HomeBloc homeBloc;
  @override
  void initState() {
    homeBloc =HomeBloc(GetIt.I<DataUsersProvider>());
    homeBloc.add(OnLoadHomePageEvent());
  }
  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: BlocBuilder<HomeBloc, HomeState>(
        bloc:homeBloc,
        builder: (BuildContext context, state) {
      if (state is HomeLoadedSuccessState) {
        return
        SafeArea(
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(bottom: 60),
                child: PageView.builder(
                     controller: controller,
                     onPageChanged: (int position){
                     },
                     itemBuilder: (BuildContext context, int position) {
                     return ListView(
                     physics: const ClampingScrollPhysics(),
                     children: [Column(
                       children: [
                           GestureDetector(
                           child: Container(
                             height:500,
                             width: double.infinity,
                             child: CachedNetworkImage(
                                 imageUrl: state.users.users[position % state.users.users.length].photos[0].url,
                                 fit: BoxFit.cover
                             ),
                           ),
                           onTap: (){
                            _showSimpleDialog(context, state.users.users[(position % state.users.users.length)].id,  state.users.users[(position % state.users.users.length)].albums);
                             },
                         ),
                      const SizedBox(height: 18,),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(state.users.users[position % state.users.users.length].name, style: TextStyle(fontSize: 28), )),
                      const SizedBox(height: 0,),
                      Text(state.users.users[position % state.users.users.length].company.name, style: TextStyle(fontSize: 24), maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,),
                         const SizedBox(height: 10,),
                         Container(
                           alignment: Alignment.centerLeft,
                             padding: const EdgeInsets.symmetric(horizontal: 16),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text('\u2022 ${state.users.users[position % state.users.users.length].email}', style: TextStyle(fontSize: 18),),
                             Text('\u2022 ${state.users.users[position % state.users.users.length].website}', style: TextStyle(fontSize: 18),),
                             Text('\u2022 ${state.users.users[position % state.users.users.length].phone}', style: TextStyle(fontSize: 18),),
                             Text('\u2022 ${state.users.users[position % state.users.users.length].address.suite}, '
                                 '${state.users.users[position % state.users.users.length].address.street}, '
                                 '${state.users.users[position % state.users.users.length].address.city}, '
                                 '${state.users.users[position % state.users.users.length].address.zipcode}, '
                                 'geo: lat: ${state.users.users[position % state.users.users.length].address.geo.lat}, '
                                 'lng: ${state.users.users[position % state.users.users.length].address.geo.lng}', style: TextStyle(fontSize: 18),),
                         ],
                         )
                         ),
                       ],
                     ),]
                   );
                  }
                 ),
              ),
              BottomButtons(controller: controller),
            ],
          ),
        );


      }
      if (state is HomeLoadedErrorState) {
        return Center(
          child: Text(state.exception.toString()),
        );
      }
      return const Center(child: CircularProgressIndicator());
        }
      )
    );
  }
}



Future<void> _showSimpleDialog(BuildContext context, int userId, List<Album> albums ) async {

  final modalBloc =ModalHomeBloc(GetIt.I<DataUsersProvider>(), albums);
  modalBloc.add(OnOpenModalHomePageEvent());

  await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return
          BlocBuilder<ModalHomeBloc, ModalHomeState>(
            bloc:modalBloc,
            builder: (BuildContext context, state) {
          if (state is ModalHomeLoadedSuccessState) {
            return
              SimpleDialog( // <-- SEE HERE
              insetPadding: const EdgeInsets.all(10),

              contentPadding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  alignment: Alignment.topRight,
                  child: IconButton(icon: const Icon(Icons.close),onPressed: (){  Navigator.of(context).pop();})
                ),

                SizedBox(width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height-200,
                  child: //Text(state.photos.photos.first.url),
                  GridView.builder(
                    primary: false,
                    padding: const EdgeInsets.all(5),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: state.photos.photos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.white,
                          child: CachedNetworkImage(
                              imageUrl: state.photos.photos[index].url,
                              fit: BoxFit.cover
                          ),
                        );
                      }
                  )
                ),
                const SizedBox(height: 20,),
              ],
            );
          }
          if (state is ModalLoadedErrorState) {
            return Center(
              child: Text(state.exception.toString()),
            );
          }

          return const Center(child: CircularProgressIndicator());
            }
          );

      });
}
