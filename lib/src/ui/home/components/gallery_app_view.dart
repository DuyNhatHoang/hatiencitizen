import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:ha_tien_app/src/blocs/events/events_bloc.dart';
import 'package:ha_tien_app/src/repositories/models/Setting.dart';
import 'package:ha_tien_app/src/repositories/models/auth/session.dart';
import 'package:ha_tien_app/src/repositories/remote/api_client.dart';
import 'package:ha_tien_app/src/repositories/remote/events/events_repo.dart';
import 'package:ha_tien_app/src/ui/base/base_page.dart';
import 'package:ha_tien_app/src/ui/detail_event/components/image_slider_component.dart';
import 'package:ha_tien_app/src/ui/home/components/photo_view.dart';
import 'package:ha_tien_app/src/utils/size_config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'gallery_item.dart';

class GalleryAppView extends StatefulWidget {
  final Session session;
  final String url;

  const GalleryAppView({Key key, this.session, this.url}) : super(key: key);

  @override
  State<GalleryAppView> createState() => _GalleryAppViewState();
}

class _GalleryAppViewState extends State<GalleryAppView> {
  BuildContext galleryContext;
  List<FileItem> serverFile = List<FileItem>();
  List<FileItem> choosefiles = List<FileItem>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return BaseSubPage(
      onBack: (){
        Navigator.of(context).pop();
      },
      title:  AppLocalizations.of(context).gallery,
      suportIcon: Icons.add_a_photo_outlined,
      suportTap: () async {
        if((await Permission.camera.isGranted)){
        } else{
          await Permission.camera.request();
        }

        await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => WebviewScaffold(
              // mediaPlaybackRequiresUserGesture: true,
              withJavascript: true,
              enableAppScheme: true,
              url: "${widget.url}?user=${widget.session.userName}&page=upfile",
              appBar: new AppBar(
                title: new Text(AppLocalizations.of(context).gallery),
              ),
            ),)
        );
        BlocProvider.of<EventsBloc>(galleryContext).add(GetGalleryFiles(username: '${widget.url}?user=${widget.session.userName}&page=api'));
      },
      child: BlocProvider<EventsBloc>(
        create: (_) =>
            EventsBloc(EventsRepo.withToken(widget.session.accessToken)),
        child:Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.89,
          child:  Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    BlocConsumer<EventsBloc, EventsState>(
                        builder: (context, state) {
                          galleryContext = context;
                          if(state is EventsInitial){
                              BlocProvider.of<EventsBloc>(context).add(GetGalleryFiles(username:'${widget.url}?user=${widget.session.userName}&page=api'));
                          }
                          if(state is GetGalleryFileLoading){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else
                          if(state is GetGalleryFileError){
                            return Center(
                              child: Text(AppLocalizations.of(context).nodata),
                            );
                          } else
                          if(state is GetGalleryFileLoaded){
                            serverFile = List<FileItem>();
                            for(var i in state.response.files){
                              serverFile.add(FileItem(file: i));
                            }
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Wrap(
                                      children: serverFile.map((e) => GalleryItem(item: e, onChanged: (e){
                                        if(e.isChoose){
                                          choosefiles.add(e);
                                        } else {
                                          choosefiles.removeWhere((element) => element.file == e.file);
                                        }
                                      },)).toList()
                                  ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
                        listener: (context, state) {

                        })
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop(choosefiles);
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Center(
                      child: Text(AppLocalizations.of(context).done, style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}

class FileItem{
   String file;
   bool isChoose;

  FileItem({this.file, this.isChoose = false});
}
