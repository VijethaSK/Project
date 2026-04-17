"""Test if Flask can access data from the database"""
from app import app, db
from app import Room, User, Admin, Reservation, Facility

with app.app_context():
    print("=" * 50)
    print("Testing Data Access from Flask")
    print("=" * 50)
    print(f"Database URI: {app.config['SQLALCHEMY_DATABASE_URI']}")
    print()
    
    try:
        rooms = Room.query.all()
        users = User.query.all()
        admins = Admin.query.all()
        reservations = Reservation.query.all()
        facilities = Facility.query.all()
        
        print(f"Rooms found: {len(rooms)}")
        for room in rooms:
            print(f"  - {room.room_number} ({room.room_type}) - ${room.price_per_night}")
        
        print(f"\nUsers found: {len(users)}")
        for user in users:
            print(f"  - {user.username} ({user.full_name})")
        
        print(f"\nAdmins found: {len(admins)}")
        for admin in admins:
            print(f"  - {admin.username} ({admin.full_name})")
        
        print(f"\nReservations found: {len(reservations)}")
        for res in reservations:
            print(f"  - ID {res.id}: User {res.user_id}, Room {res.room_id}, {res.check_in} to {res.check_out}")
        
        print(f"\nFacilities found: {len(facilities)}")
        for facility in facilities:
            print(f"  - {facility.name}")
        
        print("\n" + "=" * 50)
        print("SUCCESS: Flask can access all data from database!")
        print("=" * 50)
        
    except Exception as e:
        print(f"\nERROR: {str(e)}")
        import traceback
        traceback.print_exc()

