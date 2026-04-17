from app import app, db, Room


def seed_available_rooms():
    """Create a few rooms with no reservations so they always appear in search."""
    with app.app_context():
        demo_rooms = [
            ("401", "Single", 1800.0, 1),
            ("402", "Double", 2600.0, 2),
            ("403", "Suite", 4200.0, 3),
        ]
        created = 0
        for num, rtype, price, cap in demo_rooms:
            if not Room.query.filter_by(room_number=num).first():
                room = Room(
                    room_number=num,
                    room_type=rtype,
                    price_per_night=price,
                    capacity=cap,
                    status="Available",
                )
                db.session.add(room)
                created += 1
        if created:
            db.session.commit()
            print(f"Created {created} always-available demo rooms.")
        else:
            print("Demo rooms already exist; nothing to add.")


if __name__ == "__main__":
    seed_available_rooms()


