/// Identifies which feature's details drawer is currently shown by
/// [DetailsDrawerCubit]. To add a new details drawer (e.g. client, staff),
/// add a case here, a content widget for it, and a case in
/// `GlobalDetailsDrawer`'s dispatch switch — no other drawer's code needs to
/// change.
enum DetailsDrawerType { booking, sales }
