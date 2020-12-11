import 'package:atrons_mobile/fragments/company_material_card.dart';
import 'package:atrons_mobile/providers/loading_state.dart';
import 'package:atrons_mobile/providers/material_provider.dart';
import 'package:atrons_mobile/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyMaterialView extends StatelessWidget {
  // loadListOfCompanyMaterials
  final String materialId;
  final String title;

  CompanyMaterialView(this.materialId, this.title);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MaterialProvider>(context, listen: false);
    provider.loadListOfCompanyMaterials(materialId);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Selector<MaterialProvider, LoadingState>(
          selector: (context, model) => model.materialListLoadingState,
          builder: (context, state, child) {
            if (state == LoadingState.loading) {
              return Center(child: CircularProgressIndicator());
            }

            if (state == LoadingState.failed) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Constants.loadingFailed),
                    FlatButton(
                      onPressed: () {},
                      child: Text(Constants.retry),
                    ),
                  ],
                ),
              );
            }
            return GridView.builder(
              // physics: new NeverScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
              shrinkWrap: true,
              itemCount: provider.listOfCompanyMaterials.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 200 / 340,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: CompanyMaterialCard(
                      minimaterial: provider.listOfCompanyMaterials[index]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
