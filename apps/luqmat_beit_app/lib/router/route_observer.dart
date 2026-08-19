import 'package:flutter/material.dart';

/// Lets a screen that keeps something playing in the background (the shorts
/// feed's video) know when another route has been pushed on top of it or
/// popped back to it — a plain `isActive`/PageView-index flag alone can't
/// see that, since the covered route stays mounted underneath. Kept in its
/// own file (rather than inside `app_router.dart`) so feature pages that
/// need it don't import the router itself, which would be circular — the
/// router already imports every page to build its routes.
final routeObserver = RouteObserver<PageRoute>();
