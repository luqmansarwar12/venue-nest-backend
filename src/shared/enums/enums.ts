export enum TransformerEnum {
  Class = 'transformer.type',
  Status = 'response.status',
}

export enum UserRole {
  SUPER_ADMIN = 'super_admin',
  CONTACT_SUPPORT = 'contact_support',
  VENUE_OWNER = 'venue_owner',
  VENUE_MANAGER = 'venue_manager',
  CUSTOMER = 'customer',
}

export enum VenueType {
  WEDDING = 'wedding',
  CONFERENCE = 'conference',
  BIRTHDAY = 'birthday',
}

export enum UserStatus {
  ACTIVE = 'active',
  BANNED = 'banned',
  DEACTIVATED = 'deactivated',
  DELETED = 'deleted',
}

export enum VenueStatus {
  CREATED = 'created',
  ASSIGNED_TO_INSPECTOR = 'assigned_to_inspector',
  PENDING_APPROVAL = 'pending_approval',
  APPROVED = 'approved',
  DELETED = 'deleted',
}

export enum MenuType {
  STEAKS = 'steaks',
  CHINEESE = 'chineese',
  BEVERAGES = 'beverages',
  DESSERTS = 'desserts',
}

export enum DishStatus {
  COMING_SOON = 'coming_soon',
  AVAILABLE = 'available',
  DISCONTINUED = 'discontinued',
}
export enum BookingStatus {
  PENDING_APPROVAL = 'pending_approval',
  APPROVED = 'approved',
  CHECKED_OUT = 'checked_out',
  PAID = 'paid',
}

export enum PaymentType {
  CASH = 'cash',
  CARD = 'card',
  BANK_TRANSFER = 'bank_transfer',
}

export enum PaymentStatus {
  PENDING='pending',
  PARTIALLY_PAID='partially_paid',
  PAID='paid',
  FAILED='failed',
  REFUNDED='refunded'
}

