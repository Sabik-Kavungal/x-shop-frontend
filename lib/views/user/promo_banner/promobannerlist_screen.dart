import 'package:flutter/material.dart';
import 'package:learn/providers/promobannerVM.dart';
import 'package:provider/provider.dart';

class PromoBannerListPage extends StatelessWidget {
  const PromoBannerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Promo Banners"),
      ),
      body: Consumer<PrromoBannerVM>(
        builder: (context, vm, child) {
          if (vm.isloading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.error != null) {
            return Center(
              child: Text(
                vm.error!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (vm.pbannerList.isEmpty) {
            return const Center(child: Text("No promotions available."));
          }

          return ListView.builder(
            itemCount: vm.pbannerList.length,
            itemBuilder: (context, index) {
              final banner = vm.pbannerList[index];
              return ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    banner.imageUrl ?? '',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(banner.title ?? 'No Title'),
                subtitle: Text(banner.description ?? 'No Description'),
              );
            },
          );
        },
      ),
    );
  }
}
