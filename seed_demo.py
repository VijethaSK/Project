from datetime import date, timedelta

from app import app, db, User, Room, Facility, RoomFacility, Reservation


def seed_demo_data():
    with app.app_context():
        # Simple guard so we don't duplicate demo data
        if Reservation.query.count() >= 20:
            print("Demo data already present (20+ reservations). Skipping.")
            return

        # Users
        users = []
        user_specs = [
            ("alice", "Alice Johnson", "alice@example.com"),
            ("bob", "Bob Smith", "bob@example.com"),
            ("carol", "Carol Davis", "carol@example.com"),
        ]
        for username, full_name, email in user_specs:
            user = User.query.filter_by(username=username).first()
            if not user:
                user = User(
                    username=username,
                    full_name=full_name,
                    email=email,
                    password_hash="demo",  # not used for real login
                )
                db.session.add(user)
            users.append(user)

        # Rooms
        rooms = []
        room_specs = [
            ("101", "Single", 2000.0, 1),
            ("102", "Single", 2200.0, 1),
            ("201", "Double", 3000.0, 2),
            ("202", "Double", 3200.0, 2),
            ("301", "Suite", 5000.0, 4),
        ]
        for num, rtype, price, cap in room_specs:
            room = Room.query.filter_by(room_number=num).first()
            if not room:
                room = Room(
                    room_number=num,
                    room_type=rtype,
                    price_per_night=price,
                    capacity=cap,
                    status="Available",
                )
                db.session.add(room)
            rooms.append(room)

        # Facilities
        facility_names = ["WiFi", "AC", "Breakfast", "Pool", "Parking"]
        facilities = []
        for name in facility_names:
            fac = Facility.query.filter_by(name=name).first()
            if not fac:
                fac = Facility(name=name)
                db.session.add(fac)
            facilities.append(fac)

        db.session.commit()

        # Simple facility assignments
        for room in rooms:
            for fac in facilities[:3]:  # first 3 facilities
                if not RoomFacility.query.filter_by(
                    room_id=room.id, facility_id=fac.id
                ).first():
                    db.session.add(RoomFacility(room_id=room.id, facility_id=fac.id))

        db.session.commit()

        # 20 demo reservations spread over different dates
        today = date.today()
        demo_reservations = []
        for i in range(20):
            user = users[i % len(users)]
            room = rooms[i % len(rooms)]
            start_offset = i * 2  # every 2 days
            length = 1 + (i % 4)  # 1–4 nights
            check_in = today + timedelta(days=start_offset)
            check_out = check_in + timedelta(days=length)
            total_cost = length * room.price_per_night
            status = "Confirmed" if i % 5 != 0 else "Cancelled"
            payment_status = "Paid" if i % 3 == 0 else "Pending"

            demo_reservations.append(
                Reservation(
                    user_id=user.id,
                    room_id=room.id,
                    check_in=check_in,
                    check_out=check_out,
                    guests=min(room.capacity, 1 + (i % room.capacity)),
                    status=status,
                    total_cost=total_cost,
                    payment_status=payment_status,
                )
            )

        db.session.add_all(demo_reservations)
        db.session.commit()
        print("Inserted 20 demo reservations.")


if __name__ == "__main__":
    seed_demo_data()


