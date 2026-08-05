/// Canonical cook-facing order status vocabulary (Order Management epic,
/// CK-16/17/18/19/25). `preparing` is entered directly on Accept — there is
/// no separate "accepted" state. `delivering`/`delivered`/`returned` belong
/// to the separate Delivery Support & Admin module and are out of scope here.
enum OrderStatus { pending, preparing, done, rejected, cancelled }
