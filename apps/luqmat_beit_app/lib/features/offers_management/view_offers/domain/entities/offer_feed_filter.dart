/// CK-11's All/Active/Expired tabs — applied server-side (simulated by the
/// repository) so pagination and filtering compose correctly: switching
/// tabs resets to page one and re-queries, rather than filtering a partial
/// page of already-fetched items.
enum OfferFeedFilter { all, active, expired }
