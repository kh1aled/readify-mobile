import 'package:flutter/material.dart';
import 'package:readify_app/core/services/token_storage_service.dart';
import 'package:readify_app/features/library/data/download_service.dart';
import 'package:readify_app/features/library/data/library_remote_data_source.dart';
import 'package:readify_app/features/library/data/library_repository_impl.dart';
import 'package:readify_app/features/library/domain/entities/user_book_model.dart';
import 'package:readify_app/features/library/domain/library_repository.dart';
import 'package:readify_app/features/library/presentation/widgets/book_list.dart';
import 'package:readify_app/features/library/presentation/widgets/library_sort_row.dart';
import 'package:readify_app/features/library/presentation/widgets/library_tab_bar.dart';
import 'package:readify_app/shared/widgets/search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedTab = 0;
  final List<String> _tabs = ['All', 'Reading', 'Completed', 'Not Started'];

  late Future<List<UserBookModel>> _booksFuture;

  late final DownloadService _downloadService;
  late TokenStorageService _tokenStorage;
  late final LibraryRepository _repo;
  // Maps tab label → status value(s) from the API
  static const Map<String, List<String>> _tabStatusMap = {
    'All': [],
    'Reading': ['Reading'],
    'Completed': ['Completed'],
    'Not Started': ['Not Started'],
  };

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();

    _tokenStorage = TokenStorageService(prefs);

    _repo = LibraryRepositoryImpl(
      remote: LibraryRemoteDataSource(tokenStorage: _tokenStorage),
    );

    _downloadService = DownloadService(repository: _repo);

    setState(() {
      _booksFuture = _repo.getUserBooks();
    });
  }

  void _loadBooks() {
    if (_repo == null) return;

    setState(() {
      _booksFuture = _repo.getUserBooks();
    });
  }

  List<UserBookModel> _filterBooks(List<UserBookModel> all, String tab) {
    final statuses = _tabStatusMap[tab] ?? [];
    if (statuses.isEmpty) return all;
    return all.where((b) => statuses.contains(b.status)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final currentTab = _tabs[_selectedTab];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F8),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  const SearchBarWidget(),
                  const SizedBox(height: 16.0),
                  LibraryTabBar(
                    tabs: _tabs,
                    selectedIndex: _selectedTab,
                    onTabSelected: (i) => setState(() => _selectedTab = i),
                    primaryColor: primary,
                  ),
                  const SizedBox(height: 16.0),
                  const LibrarySortRow(),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),

            // ── Book list ──────────────────────────────────────────
            Expanded(
              child: FutureBuilder<List<UserBookModel>>(
                future: _booksFuture,
                builder: (context, snapshot) {
                  // Loading
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildLoadingShimmer();
                  }

                  // Error
                  if (snapshot.hasError) {
                    return _buildError(snapshot.error.toString());
                  }

                  final all = snapshot.data ?? [];
                  final filtered = _filterBooks(all, currentTab);

                  return BookList(
                    books: filtered,
                    primaryColor: primary,
                    downloadService: _downloadService,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Private helpers ───────────────────────────────────────────────────

  Widget _buildLoadingShimmer() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      itemCount: 5,
      separatorBuilder: (_, __) =>
          Divider(color: Colors.grey.shade200, height: 1),
      itemBuilder: (_, __) => _ShimmerRow(),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              'Something went wrong',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              error,
              style: const TextStyle(fontSize: 11, color: Colors.black38),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _loadBooks,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shimmer placeholder ───────────────────────────────────────────────────

class _ShimmerRow extends StatefulWidget {
  @override
  State<_ShimmerRow> createState() => _ShimmerRowState();
}

class _ShimmerRowState extends State<_ShimmerRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 0.7).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) {
        final color = Colors.grey.shade300.withOpacity(_anim.value);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 75,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 12, width: 160, color: color),
                    const SizedBox(height: 6),
                    Container(height: 10, width: 100, color: color),
                    const SizedBox(height: 10),
                    Container(height: 4, color: color),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
