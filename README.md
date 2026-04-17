## Hotel DBMS Mini Project (Flask + SQLite)

This project is a simple Hotel Management / Booking DBMS implemented using **Flask** and **SQLite**.  
It demonstrates core DBMS concepts: entities, relationships, constraints, joins, and non-trivial queries for availability and conflict checks.

### 1. Features vs Your Requirements

- **User Registration & Login**
  - Users can register and log in with username/password.
  - User details stored in `USER` table (`user` model).

- **Admin Login**
  - Default admin auto-created: username `admin`, password `admin123`.
  - Admin details stored in `ADMIN` table (`admin` model).
  - Only admin can manage rooms, facilities, and view all reservations.

- **Room Management (Admin Only)**
  - Add/modify/delete rooms.
  - Update room status: `Available / Booked / Maintenance`.
  - View list of all rooms.
  - Uses `ROOM` entity.

- **Facility Management (Admin Only)**
  - Add facilities (WiFi, AC, Breakfast, Pool, Parking, etc.).
  - Assign/remove facilities per room.
  - Uses `FACILITY` + `ROOM_FACILITY` (many-to-many).

- **Room Availability Check**
  - User can search rooms:
    - by date range (check-in / check-out)
    - by room type
    - by price range
  - Implemented as a non-trivial query that excludes rooms with overlapping confirmed reservations.

- **Room Reservation / Booking**
  - User selects room, enters dates and number of guests, confirms booking.
  - Writes to `RESERVATION` entity with `total_cost` and `payment_status`.

- **Automatic Booking Conflict Check**
  - System prevents double booking:
    - Before creating a reservation, it checks for overlapping `Confirmed` reservations for that room.
    - Condition: `existing.check_in < new_check_out AND new_check_in < existing.check_out`.

- **Booking Cancellation**
  - User can cancel their own bookings.
  - Admin can cancel any reservation.
  - Status moves to `Cancelled`.

- **Payment Handling**
  - `total_cost = nights × price_per_night`.
  - `payment_status = Pending / Paid / Failed`.
  - Admin screen to update payment status.

- **Booking History**
  - User: past and upcoming bookings with status and payment details.
  - Admin: all reservations (can observe patterns manually).

### 2. How to Run (Windows)

From the project root (`DBMS` directory):

```bash
py -m venv venv
venv\Scripts\activate
pip install -r requirements.txt

set FLASK_APP=app.py
python app.py
```

Then open your browser and go to: `http://127.0.0.1:5000/`

On first run, the app will:
- Create `hotel.db` SQLite database.
- Create all tables.
- Insert a default admin (`admin` / `admin123`) if none exists.

### 3. Main Database Entities

- **USER**
  - Columns: `id, username, password_hash, full_name, email, created_at`
  - Model: `User` in `app.py`

- **ADMIN**
  - Columns: `id, username, password_hash, full_name, email, created_at`
  - Model: `Admin`

- **ROOM**
  - Columns: `id, room_number, room_type, price_per_night, capacity, status`
  - Model: `Room`

- **FACILITY**
  - Columns: `id, name`
  - Model: `Facility`

- **ROOM_FACILITY**
  - Columns: `room_id, facility_id` (composite PK)
  - Model: `RoomFacility`
  - Represents many-to-many between `ROOM` and `FACILITY`.

- **RESERVATION**
  - Columns:
    - `id, user_id, room_id, check_in, check_out, guests`
    - `status` (`Confirmed` / `Cancelled`)
    - `total_cost, payment_status` (`Pending` / `Paid` / `Failed`)
    - `created_at`
  - Model: `Reservation`

See `schema.sql` for a pure-SQL version of the schema with constraints and indexes.

### 4. Important DB/Logic Queries

- **Availability Query (used in `/search`)**
  - Steps:
    1) Filter rooms by room type and price range.
    2) Exclude rooms that have any `Confirmed` reservation overlapping the requested date range.

- **Conflict Check (used in `/book/<id>`)**
  - Before insert:
    - Count reservations where:
      - `room_id = ?`
      - `status = 'Confirmed'`
      - `existing.check_in < new_check_out`
      - `new_check_in < existing.check_out`
    - If count > 0 → reject booking.

- **Cost Calculation**
  - `nights = (check_out - check_in).days`
  - `total_cost = nights * price_per_night`

These points are good to explain in a viva or project report.

### 5. Where to Look in Code

- `app.py`
  - Models: `User`, `Admin`, `Room`, `Facility`, `RoomFacility`, `Reservation`
  - Auth routes: `/register`, `/login`, `/admin/login`, `/logout`
  - Dashboards: `/user/dashboard`, `/admin/dashboard`
  - Room management: `/admin/rooms`, `/admin/rooms/<id>/edit`, `/admin/rooms/<id>/delete`
  - Facilities management: `/admin/facilities`, `/admin/rooms/<id>/facilities`
  - Availability & booking: `/search`, `/book/<room_id>`
  - Booking history: `/user/bookings`, `/admin/reservations`
  - Cancellation & payments:
    - `/booking/<id>/cancel`
    - `/admin/booking/<id>/cancel`
    - `/admin/booking/<id>/payment`

- `templates/`
  - `base.html` – layout + navbar + flash messages.
  - `index.html` – home page.
  - `register.html`, `user_login.html`, `admin_login.html`.
  - `user_dashboard.html`, `admin_dashboard.html`.
  - `manage_rooms.html`, `manage_facilities.html`.
  - `search_rooms.html`, `book_room.html`.
  - `user_bookings.html`, `admin_reservations.html`.

You can extend this project further with reports, charts, or more complex analytics on reservations and customer patterns.


