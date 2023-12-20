import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/config/custom_colors.dart';
import 'package:greengrocer/src/pages/common_widgets/app_name_widget.dart';
import 'package:greengrocer/src/pages/common_widgets/custom_shimmer.dart';
import 'package:greengrocer/src/pages/home/controller/home_controller.dart';
import 'package:greengrocer/src/pages/home/view/components/category_tile.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;
import 'package:greengrocer/src/pages/home/view/components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  final TextEditingController searchController = TextEditingController();
  final controller = Get.find<HomeController>();

  void listClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const AppNameWidget(
          textSize: 30,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
              right: 15,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Badge(
                alignment: Alignment.topRight,
                backgroundColor: CustomColors.customContrastColor,
                label: const Text(
                  "0",
                  style: TextStyle(fontSize: 12),
                ),
                child: AddToCartIcon(
                  key: cartKey,
                  badgeOptions: const BadgeOptions(active: false),
                  icon: Icon(
                    Icons.shopping_cart,
                    color: CustomColors.customSwatchColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      body: AddToCartAnimation(
        cartKey: cartKey,
        // dragAnimation: const DragToCartAnimationOptions(
        //   rotation: true,
        // ),
        // jumpAnimation: const JumpAnimationOptions(),
        createAddToCartAnimation: (runAddToCartAnimation) {
          this.runAddToCartAnimation = runAddToCartAnimation;
        },
        child: Column(
          children: [
            // campo de pesquisa
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: GetBuilder<HomeController>(
                builder: (controller) {
                  return TextFormField(
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    controller: searchController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      hintText: "Pesquise aqui...",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: CustomColors.customContrastColor,
                        size: 21,
                      ),
                      suffixIcon: controller.searchTitle.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                searchController.clear();
                                controller.searchTitle.value = "";
                                FocusScope.of(context).unfocus();
                              },
                              icon: Icon(
                                Icons.close,
                                size: 21,
                                color: CustomColors.customSwatchColor,
                              ),
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      controller.searchTitle.value = value;
                    },
                  );
                },
              ),
            ),

            // categorias
            GetBuilder<HomeController>(
              builder: (controller) {
                return Container(
                  padding: const EdgeInsets.only(left: 25),
                  height: 40,
                  child: !controller.isCategoryLoading
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            final category = controller.allCategories[index];

                            return CategoryTile(
                              onPressed: () {
                                controller.selectCategory(category);
                              },
                              category: category.title,
                              isSelected:
                                  category == controller.currentCategory,
                            );
                          },
                          separatorBuilder: (_, __) => const SizedBox(
                            width: 10,
                          ),
                          itemCount: controller.allCategories.length,
                        )
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            app_data.categories.length,
                            (index) => Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(right: 12),
                              child: CustomShimmer(
                                height: 20,
                                width: 60,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                );
              },
            ),

            // grid
            GetBuilder<HomeController>(
              builder: (controller) {
                return Expanded(
                  child: !controller.isProductLoading
                      ? GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 2,
                            childAspectRatio: 9 / 11.5,
                          ),
                          itemCount: controller.allProducts.length,
                          itemBuilder: (_, index) {
                            if (((index + 1) ==
                                    controller.allProducts.length) &&
                                !controller.isLastPage) {
                              controller.loadMoreProducts();
                            }
                            return ItemTile(
                              item: controller.allProducts[index],
                              onClick: runAddToCartAnimation,
                            );
                          },
                        )
                      : GridView.count(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 8,
                          childAspectRatio: 9 / 11.5,
                          children: List.generate(
                            10,
                            (index) => CustomShimmer(
                              height: double.infinity,
                              width: double.infinity,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
