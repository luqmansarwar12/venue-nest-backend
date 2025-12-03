# Database Schema Documentation

## Models Overview

### User 

- Stores user information (customers and venue owners).

### Venue

- Represents a venue created by a venue owner.

### Menu

- Each venue can have one or more menus (e.g., Lunch Menu, Dinner Menu).

### Dish

- Individual food items.
- A dish can belong to multiple menus (or no menu initially).

### DishOnMenu

- Junction table to manage **many-to-many** relation between `Dish` and `Menu`.
- Prevents data duplication and keeps dishes normalized.

### Booking

- Created by the user (customer) for a specific venue and menu.
- Tracks booking time, guest count, and prices.
- Booking has a status to manage its lifecycle.

### Payment

- Linked to a booking.
- Tracks payment information (advance, pending bill, etc.)
- Payment also has a status to track payment lifecycle.

---

## Status Fields Notes

We are using `enum` fields for status tracking across multiple models instead of plain strings.  
This improves **data consistency**, **validation**, and **makes it easier to manage status transitions** inside code.

Example:

- `BookingStatus` Enum:
  - `PENDING_APPROVAL`
  - `APPROVED`
  - `CHECKED_OUT`
  - `PAID`

If required in future, additional statuses like `CANCELLED`, `REJECTED`, or `EXPIRED` can be easily added.

---

## Why Use Dish, Menu, and DishOnMenu Tables?

Instead of embedding dishes inside menus directly, we introduced a third table `DishOnMenu` for the following reasons:

- **Normalization**: Each Dish (with 8-10 fields) should exist only once.
- **Avoid Duplication**: If dishes were saved separately for each menu, the same dish data (name, price, ingredients, etc.) would be duplicated across menus.
- **Efficiency**: By linking dishes through a third table, we only store `dish_id` and `menu_id`, saving database space and making updates easier.
- **Flexibility**: One dish can be added/removed from multiple menus without data inconsistency.

Thus, this design is **more scalable**, **efficient**, and **aligned with database normalization best practices**.

---

## Future Improvements (Notes)

- Consider adding a soft delete (`deletedAt`) field in models like `Dish`, `Menu`, and `Booking`.
- Add audit fields (`createdBy`, `updatedBy`) if multi-admin handling is needed later.

---
