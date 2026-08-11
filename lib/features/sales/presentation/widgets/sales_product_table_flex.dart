/// Column flex ratios for the selected-products table in [EditSalesScreen],
/// shared between [SalesFormProductListHeader] and [SalesFormProductTableRow]
/// so header and row cells stay aligned.
abstract final class SalesProductTableFlex {
  /// Sl. No. is deliberately half of [column] since it only ever needs to
  /// fit a couple of digits.
  static const int slNo = 1;
  static const int column = 2;
  static const int items = 6;
  static const int specifications = 4;

  /// Minimum width the table needs to lay out its columns without
  /// overflowing. Below this, the table scrolls horizontally instead of
  /// squeezing its columns.
  static const double minTableWidth = 1000;
}
