import 'package:atrons_mobile/fragments/company_material_card.dart';
import 'package:atrons_mobile/models/material.dart';
import 'package:atrons_mobile/providers/loading_state.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
import 'package:atrons_mobile/utils/helper_funcs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyMaterialView extends StatefulWidget {
  // loadListOfCompanyMaterials
  final String materialId;
  final String title;

  CompanyMaterialView(this.materialId, this.title);

  @override
  _CompanyMaterialViewState createState() => _CompanyMaterialViewState();
}

class _CompanyMaterialViewState extends State<CompanyMaterialView> {
  List<MiniMaterial> _materials;

  LoadingState loadingState = LoadingState.failed;

  @override
  void initState() {
    loadCompanyMaterials(context);
    super.initState();
  }

  void loadCompanyMaterials(BuildContext context) async {
    final provider = Provider.of<MaterialProvider>(context, listen: false);
    setState(() {
      loadingState = LoadingState.loading;
    });
    await provider
        .loadListOfCompanyMaterials(widget.materialId)
        .then((materials) {
      _materials = materials;
      setState(() {
        loadingState = LoadingState.success;
      });
    }).catchError((err) {
      setState(() {
        loadingState = LoadingState.failed;
      });
    });
  }

  Widget _buildReloadButton() {
    return Center(
      child: Column(
        children: [
          Text('Loading failed'),
          addVerticalSpace(10),
          FlatButton(
            onPressed: () {
              loadCompanyMaterials(context);
            },
            child: Text('Retry'),
          )
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildEmptyMessage() {
    return Center(child: Text('No materials found'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: loadingState == LoadingState.failed
              ? _buildReloadButton()
              : loadingState == LoadingState.loading
                  ? _buildLoading()
                  : _materials.length == 0
                      ? _buildEmptyMessage()
                      : GridView.builder(
                          // physics: new NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
                          shrinkWrap: true,
                          itemCount: _materials.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 200 / 340,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final material = _materials[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child:
                                  CompanyMaterialCard(minimaterial: material),
                            );
                          },
                        )),
    );
  }
}
