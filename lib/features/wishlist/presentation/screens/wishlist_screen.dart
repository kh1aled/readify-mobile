import 'package:flutter/material.dart';
import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/features/wishlist/data/repositories/wishlist_repository.dart';
import 'package:readify_app/features/wishlist/data/services/wishlist_service.dart';
import 'package:readify_app/features/wishlist/domain/models/wishlist_item_model.dart';
import 'package:readify_app/features/wishlist/presentation/widgets/wishlist_grid.dart';
import 'package:readify_app/shared/widgets/search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => WishlistScreenState();
}

class WishlistScreenState extends State<WishlistScreen> {
  late final WishlistRepository _repository;

  List<WishlistItemModel> _items = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initAndLoad();
  }

  Future<void> refresh() async {
    await _loadWishlist();
  }

  Future<void> _initAndLoad() async {
    final prefs = await SharedPreferences.getInstance();
    _repository = WishlistRepository(tokenStorage: TokenStorageService(prefs));
    await _loadWishlist();
  }

  Future<void> _loadWishlist() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final items = await _repository.getWishlist();
      if (mounted) {
        setState(() {
          _items = items;
          _isLoading = false;
        });
      }
    } on WishlistException catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.message;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Unexpected error: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F8),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchBarWidget(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Wishlist',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey.shade800,
                        ),
                      ),

                      IconButton(
                        onPressed: _loadWishlist,
                        icon: const Icon(Icons.refresh_rounded),
                        color: Colors.grey.shade700,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _isLoading ? 'Loading...' : '${_items.length} books saved',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                  ),
                ],
              ),
            ),
            Expanded(child: _buildBody(primary)),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(Color primary) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wifi_off_rounded,
                size: 48,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 12),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _loadWishlist,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return WishlistGrid(
      items: _items,
      primaryColor: primary,
      onRefresh: _loadWishlist,
    );
  }
}
