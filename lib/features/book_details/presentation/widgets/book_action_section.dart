import 'package:flutter/material.dart';
import 'package:readify_app/features/book_details/presentation/screens/reader_screen.dart';
import '../../data/book_remote_data_source.dart';
import '../../domain/book_details_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:readify_app/core/services/token_storage_service.dart';

class BookActionSection extends StatefulWidget {
  final BookDetailsModel book;
  final Future<void> Function() onReviewSubmitted;

  const BookActionSection({
    super.key,
    required this.book,
    required this.onReviewSubmitted,
  });

  @override
  State<BookActionSection> createState() => _BookActionSectionState();
}

class _BookActionSectionState extends State<BookActionSection> {
  bool _isWishlisted = false;
  bool _isInLibrary = false;
  bool _isLoading = false;

  final _dataSource = BookRemoteDataSource();
  TokenStorageService? _tokenStorage;

  @override
  void initState() {
    super.initState();
    _initToken();
  }

  Future<void> _initToken() async {
    final prefs = await SharedPreferences.getInstance();
    _tokenStorage = TokenStorageService(prefs);
    await _checkIfPurchased();
  }

  Future<void> _purchaseBook() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final token = _tokenStorage?.getToken();

      if (token == null) {
        throw Exception("User not logged in");
      }

      await _dataSource.purchaseBook(widget.book.id, token);

      setState(() {
        _isInLibrary = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Book purchased successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Purchase failed: $e')));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _checkIfPurchased() async {
    try {
      final token = _tokenStorage?.getToken();
      if (token == null) return;

      final isPurchased = await _dataSource.isBookPurchased(
        widget.book.id,
        token,
      );

      if (mounted) {
        setState(() {
          _isInLibrary = isPurchased;
        });
      }
    } catch (e) {
      print("check purchase error: $e");
    }
  }

  void _handleMainAction() async {
    if (_isInLibrary) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PdfReaderScreen(
            url: widget.book.fileUrl,
          ),
        ),
      );
      return;
    }

    if (widget.book.price == 0) {
      await _purchaseBook();
    } else {
      _showPaymentSheet();
    }
  }

  void _showPaymentSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Purchase Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await _purchaseBook();
                },
                child: const Text('Buy in App'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getButtonText() {
    if (_isInLibrary) return 'Read Now';
    if (widget.book.price == 0) return 'Get for Free';
    return 'Buy \$${widget.book.price.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(
        AppConstants.pagePadding,
        16,
        AppConstants.pagePadding,
        0,
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: AppConstants.buyButtonHeight,
            child: ElevatedButton(
              onPressed: _handleMainAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.teal,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.buttonRadius,
                  ),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      _getButtonText(),
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 6),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'list price: \$${widget.book.price.toStringAsFixed(2)}',
              style: AppTextStyles.priceStrike,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              _IconActionButton(
                icon: _isWishlisted ? Icons.favorite : Icons.favorite_border,
                iconColor: _isWishlisted ? AppColors.red : AppColors.textLight,
                onTap: () => setState(() => _isWishlisted = !_isWishlisted),
                tooltip: 'Wishlist',
              ),
              const SizedBox(width: 10),

              Expanded(
                child: _LabelActionButton(
                  icon: _isInLibrary
                      ? Icons.check_circle
                      : Icons.add_circle_outline,
                  label: _isInLibrary ? 'In Library' : 'Add to Library',
                  active: _isInLibrary,
                  onTap: () => setState(() => _isInLibrary = !_isInLibrary),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _IconActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final String tooltip;

  const _IconActionButton({
    required this.icon,
    required this.iconColor,
    required this.onTap,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: tooltip,
        child: Container(
          width: 48,
          height: 44,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}

class _LabelActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback? onTap;

  const _LabelActionButton({
    required this.icon,
    required this.label,
    required this.active,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 44,
        decoration: BoxDecoration(
          color: active ? AppColors.tealLight : Colors.transparent,
          border: Border.all(
            color: active ? AppColors.tealBorder : AppColors.border,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: active ? AppColors.teal : AppColors.textLight),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: active ? AppColors.teal : AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
