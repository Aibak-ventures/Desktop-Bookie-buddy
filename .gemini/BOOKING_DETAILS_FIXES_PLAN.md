# Booking Details Drawer Fixes - Implementation Plan

## Changes Required

### 1. ✅ Add "Cancelled" Tab to All Bookings
- [x] Added 'Cancelled' to status map
- [x] Added 'cancelled' field to StatusCountsModel
- [ ] Regenerate Freezed code (in progress)

### 2. ✅ Fix Delivery Status Overflow
- [x] Wrapped status.name in Flexible widget with TextOverflow.ellipsis
- Applied to both completed and editable status displays

### 3. Show Locations Only Once (Not Per Item)
**Current**: Location details shown inside each vehicle item loop
**Required**: Show location details once after all items

Changes needed in `_buildItemDetails`:
- Remove location details from inside the item map (lines 960-1052)
- Add location details after all items, before notes section
- Only show if ANY item is a vehicle

### 4. Show Documents Count in Heading
**Current**: "Documents"
**Required**: "Documents" (3/5)" or similar showing uploaded/total

Changes needed in `_buildDocumentsSection`:
- Count total documents
- Count uploaded documents (non-null docUrl)
- Update heading text

### 5. Move Documents Section Under Payments
**Current Order**:
- Dates
- Documents  
- Items
- Customer  
- Payment

**Required Order**:
- Dates
- Items
- Customer
- Payment
- Documents (moved here)

### 6. Fix Payment History Expansion State
**Problem**: When switching bookings, payment history stays expanded from previous booking

**Solution**: Add a state variable to track expanded state, reset it when booking ID changes
- Add `_expandedPaymentHistoryBookingId` variable
- Reset when drawer opens with new booking ID
- Pass to payment details section

### 7. Validate Mark as Completed - Payment Check
**Required**: Don't allow marking as completed if balance > 0

Changes in `_buildActionButtons`:
- Check `booking.balanceDue > 0` before allowing completion
- Show snackbar message if validation fails

### 8. Validate Mark as Completed - Delivery Status Check
**Required**: Only allow marking as completed if deliveryStatus == "Returned" 

Changes in `_buildActionButtons`:
- Check `booking.deliveryStatus == DeliveryStatus.returned` 
- Show snackbar message explaining requirement

## Implementation Order
1. ✅ Cancelled tab (done)
2. ✅ Delivery status overflow (done)
3. Location details consolidation
4. Documents count in heading
5. Payment history state reset
6. Validation for mark as completed
7. Move documents section
