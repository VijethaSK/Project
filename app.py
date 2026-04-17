import os
from datetime import datetime, date
from dotenv import load_dotenv

from flask import (
    Flask,
    render_template,
    request,
    redirect,
    url_for,
    session,
    flash,
    jsonify,
)
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash

# Load environment variables from .env file
load_dotenv()

app = Flask(__name__)
app.config["SECRET_KEY"] = os.getenv("SECRET_KEY", "dev-secret-key-change-me-in-production")
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

# Database Configuration
# Choose your database by setting DATABASE_TYPE environment variable
# Options: 'sqlite', 'mysql', 'postgresql', 'mssql'
DATABASE_TYPE = os.getenv("DATABASE_TYPE", "sqlite").lower()

if DATABASE_TYPE == "mysql":
    # MySQL/MariaDB Configuration
    DB_HOST = os.getenv("DB_HOST", "localhost")
    DB_PORT = os.getenv("DB_PORT", "3306")
    DB_USER = os.getenv("DB_USER", "root")
    DB_PASSWORD = os.getenv("DB_PASSWORD", "")
    DB_NAME = os.getenv("DB_NAME", "hotel_dbms")
    # Use pymysql or mysqlclient
    app.config["SQLALCHEMY_DATABASE_URI"] = (
        f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    )
    # Alternative with mysqlclient (faster):
    # app.config["SQLALCHEMY_DATABASE_URI"] = (
    #     f"mysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    # )

elif DATABASE_TYPE == "postgresql":
    # PostgreSQL Configuration
    DB_HOST = os.getenv("DB_HOST", "localhost")
    DB_PORT = os.getenv("DB_PORT", "5432")
    DB_USER = os.getenv("DB_USER", "postgres")
    DB_PASSWORD = os.getenv("DB_PASSWORD", "")
    DB_NAME = os.getenv("DB_NAME", "hotel_dbms")
    app.config["SQLALCHEMY_DATABASE_URI"] = (
        f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    )

elif DATABASE_TYPE == "mssql":
    # SQL Server Configuration
    DB_HOST = os.getenv("DB_HOST", "localhost")
    DB_PORT = os.getenv("DB_PORT", "1433")
    DB_USER = os.getenv("DB_USER", "sa")
    DB_PASSWORD = os.getenv("DB_PASSWORD", "")
    DB_NAME = os.getenv("DB_NAME", "hotel_dbms")
    # Using pyodbc
    app.config["SQLALCHEMY_DATABASE_URI"] = (
        f"mssql+pyodbc://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
        f"?driver=ODBC+Driver+17+for+SQL+Server"
    )
    # Alternative with pymssql:
    # app.config["SQLALCHEMY_DATABASE_URI"] = (
    #     f"mssql+pymssql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    # )

else:
    # Default: SQLite (for development)
    app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///hotel.db"

db = SQLAlchemy(app)


# MODELS

class User(db.Model):
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, unique=True, nullable=False)
    password_hash = db.Column(db.String, nullable=False)
    full_name = db.Column(db.String, nullable=False)
    email = db.Column(db.String, unique=True, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)


class Admin(db.Model):
    __tablename__ = "admin"
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String, unique=True, nullable=False)
    password_hash = db.Column(db.String, nullable=False)
    full_name = db.Column(db.String, nullable=False)
    email = db.Column(db.String, unique=True, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)


class Room(db.Model):
    __tablename__ = "room"
    id = db.Column(db.Integer, primary_key=True)
    room_number = db.Column(db.String, unique=True, nullable=False)
    room_type = db.Column(db.String, nullable=False)
    price_per_night = db.Column(db.Float, nullable=False)
    capacity = db.Column(db.Integer, nullable=False)
    status = db.Column(db.String, nullable=False, default="Available")


class Facility(db.Model):
    __tablename__ = "facility"
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String, unique=True, nullable=False)


class RoomFacility(db.Model):
    __tablename__ = "room_facility"
    room_id = db.Column(db.Integer, db.ForeignKey("room.id"), primary_key=True)
    facility_id = db.Column(
        db.Integer, db.ForeignKey("facility.id"), primary_key=True
    )

    room = db.relationship("Room", backref="room_facilities")
    facility = db.relationship("Facility", backref="room_facilities")


class Reservation(db.Model):
    __tablename__ = "reservation"
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey("user.id"), nullable=False)
    room_id = db.Column(db.Integer, db.ForeignKey("room.id"), nullable=False)
    check_in = db.Column(db.Date, nullable=False)
    check_out = db.Column(db.Date, nullable=False)
    guests = db.Column(db.Integer, nullable=False)
    status = db.Column(db.String, nullable=False, default="Confirmed")
    total_cost = db.Column(db.Float, nullable=False)
    payment_status = db.Column(db.String, nullable=False, default="Pending")
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    user = db.relationship("User", backref="reservations")
    room = db.relationship("Room", backref="reservations")


# HELPERS

def current_user():
    if "user_id" in session:
        return User.query.get(session["user_id"])
    return None


def current_admin():
    if "admin_id" in session:
        return Admin.query.get(session["admin_id"])
    return None


def login_required(view_func):
    from functools import wraps

    @wraps(view_func)
    def wrapper(*args, **kwargs):
        if not current_user():
            flash("Please log in as user first.", "warning")
            return redirect(url_for("user_login"))
        return view_func(*args, **kwargs)

    return wrapper


def admin_required(view_func):
    from functools import wraps

    @wraps(view_func)
    def wrapper(*args, **kwargs):
        if not current_admin():
            flash("Admin access required.", "danger")
            return redirect(url_for("admin_login"))
        return view_func(*args, **kwargs)

    return wrapper


def init_db():
    db.create_all()
    # Seed default admin if none exists
    if not Admin.query.first():
        admin = Admin(
            username="admin",
            full_name="Default Admin",
            email="admin@example.com",
            password_hash=generate_password_hash("admin123"),
        )
        db.session.add(admin)
        db.session.commit()


@app.route("/")
def index():
    return render_template("index.html", user=current_user(), admin=current_admin())


# AUTHENTICATION

@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form["username"].strip()
        full_name = request.form["full_name"].strip()
        email = request.form["email"].strip()
        password = request.form["password"]

        if User.query.filter(
            (User.username == username) | (User.email == email)
        ).first():
            flash("Username or email already exists.", "danger")
            return redirect(url_for("register"))

        user = User(
            username=username,
            full_name=full_name,
            email=email,
            password_hash=generate_password_hash(password),
        )
        db.session.add(user)
        db.session.commit()
        flash("Registration successful. Please log in.", "success")
        return redirect(url_for("user_login"))

    return render_template("register.html")


@app.route("/login", methods=["GET", "POST"])
def user_login():
    if request.method == "POST":
        username = request.form["username"].strip()
        password = request.form["password"]

        user = User.query.filter_by(username=username).first()
        if not user or not check_password_hash(user.password_hash, password):
            flash("Invalid username or password.", "danger")
            return redirect(url_for("user_login"))

        session.clear()
        session["user_id"] = user.id
        flash("Logged in successfully.", "success")
        return redirect(url_for("user_dashboard"))

    return render_template("user_login.html")


@app.route("/admin/login", methods=["GET", "POST"])
def admin_login():
    if request.method == "POST":
        username = request.form["username"].strip()
        password = request.form["password"]

        admin = Admin.query.filter_by(username=username).first()
        if not admin or not check_password_hash(admin.password_hash, password):
            flash("Invalid admin credentials.", "danger")
            return redirect(url_for("admin_login"))

        session.clear()
        session["admin_id"] = admin.id
        flash("Admin logged in.", "success")
        return redirect(url_for("admin_dashboard"))

    return render_template("admin_login.html")


@app.route("/logout")
def logout():
    session.clear()
    flash("Logged out.", "info")
    return redirect(url_for("index"))


# DASHBOARDS

@app.route("/user/dashboard")
@login_required
def user_dashboard():
    return render_template("user_dashboard.html", user=current_user())


@app.route("/admin/dashboard")
@admin_required
def admin_dashboard():
    return render_template("admin_dashboard.html", admin=current_admin())


# ROOM MANAGEMENT (ADMIN)

@app.route("/admin/rooms", methods=["GET", "POST"])
@admin_required
def manage_rooms():
    if request.method == "POST":
        room_number = request.form["room_number"].strip()
        room_type = request.form["room_type"].strip()
        price_per_night = float(request.form["price_per_night"])
        capacity = int(request.form["capacity"])

        room = Room(
            room_number=room_number,
            room_type=room_type,
            price_per_night=price_per_night,
            capacity=capacity,
            status="Available",
        )
        db.session.add(room)
        db.session.commit()
        flash("Room added.", "success")
        return redirect(url_for("manage_rooms"))

    rooms = Room.query.order_by(Room.room_number).all()
    return render_template("manage_rooms.html", admin=current_admin(), rooms=rooms)


@app.route("/admin/rooms/<int:room_id>/edit", methods=["POST"])
@admin_required
def edit_room(room_id):
    room = Room.query.get_or_404(room_id)
    room.room_type = request.form["room_type"].strip()
    room.price_per_night = float(request.form["price_per_night"])
    room.capacity = int(request.form["capacity"])
    room.status = request.form["status"]
    db.session.commit()
    flash("Room updated.", "success")
    return redirect(url_for("manage_rooms"))


@app.route("/admin/rooms/<int:room_id>/delete", methods=["POST"])
@admin_required
def delete_room(room_id):
    room = Room.query.get_or_404(room_id)
    db.session.delete(room)
    db.session.commit()
    flash("Room deleted.", "info")
    return redirect(url_for("manage_rooms"))


# FACILITY MANAGEMENT (ADMIN)

@app.route("/admin/facilities", methods=["GET", "POST"])
@admin_required
def manage_facilities():
    if request.method == "POST":
        name = request.form["name"].strip()
        if not Facility.query.filter_by(name=name).first():
            db.session.add(Facility(name=name))
            db.session.commit()
            flash("Facility added.", "success")
        else:
            flash("Facility already exists.", "warning")
        return redirect(url_for("manage_facilities"))

    facilities = Facility.query.order_by(Facility.name).all()
    rooms = Room.query.order_by(Room.room_number).all()
    return render_template(
        "manage_facilities.html",
        admin=current_admin(),
        facilities=facilities,
        rooms=rooms,
    )


@app.route("/admin/rooms/<int:room_id>/facilities", methods=["POST"])
@admin_required
def update_room_facilities(room_id):
    room = Room.query.get_or_404(room_id)
    selected_ids = request.form.getlist("facility_ids")
    selected_ids = {int(fid) for fid in selected_ids}

    # Remove unselected
    for rf in list(room.room_facilities):
        if rf.facility_id not in selected_ids:
            db.session.delete(rf)

    # Add new
    existing_ids = {rf.facility_id for rf in room.room_facilities}
    for fid in selected_ids - existing_ids:
        db.session.add(RoomFacility(room_id=room.id, facility_id=fid))

    db.session.commit()
    flash("Room facilities updated.", "success")
    return redirect(url_for("manage_facilities"))


# AVAILABILITY & BOOKING

def dates_overlap(start1, end1, start2, end2):
    # Assuming check_out is exclusive
    return start1 < end2 and start2 < end1


@app.route("/search", methods=["GET", "POST"])
def search_rooms():
    user = current_user()
    rooms = []
    check_in = check_out = None
    room_type = ""
    min_price = max_price = None

    if request.method == "POST":
        check_in = date.fromisoformat(request.form["check_in"])
        check_out = date.fromisoformat(request.form["check_out"])
        room_type = request.form.get("room_type", "").strip()
        min_price = request.form.get("min_price") or None
        max_price = request.form.get("max_price") or None

        q = Room.query.filter(Room.status != "Maintenance")
        if room_type:
            q = q.filter(Room.room_type == room_type)
        if min_price:
            q = q.filter(Room.price_per_night >= float(min_price))
        if max_price:
            q = q.filter(Room.price_per_night <= float(max_price))

        candidate_rooms = q.all()
        rooms = []
        for room in candidate_rooms:
            conflicts = (
                Reservation.query.filter(
                    Reservation.room_id == room.id,
                    Reservation.status == "Confirmed",
                )
                .filter(
                    Reservation.check_in < check_out,
                    check_in < Reservation.check_out,
                )
                .count()
            )
            if conflicts == 0:
                rooms.append(room)

    return render_template(
        "search_rooms.html",
        user=user,
        admin=current_admin(),
        rooms=rooms,
        check_in=check_in,
        check_out=check_out,
        room_type=room_type,
        min_price=min_price,
        max_price=max_price,
    )


@app.route("/book/<int:room_id>", methods=["GET", "POST"])
@login_required
def book_room(room_id):
    room = Room.query.get_or_404(room_id)
    user = current_user()

    if request.method == "POST":
        check_in = date.fromisoformat(request.form["check_in"])
        check_out = date.fromisoformat(request.form["check_out"])
        guests = int(request.form["guests"])

        if guests > room.capacity:
            flash("Number of guests exceeds room capacity.", "danger")
            return redirect(url_for("book_room", room_id=room.id))

        # Conflict check
        conflicts = (
            Reservation.query.filter(
                Reservation.room_id == room.id,
                Reservation.status == "Confirmed",
            )
            .filter(
                Reservation.check_in < check_out,
                check_in < Reservation.check_out,
            )
            .count()
        )
        if conflicts > 0:
            flash("Room is not available for the selected dates.", "danger")
            return redirect(url_for("search_rooms"))

        nights = (check_out - check_in).days
        total_cost = nights * room.price_per_night

        reservation = Reservation(
            user_id=user.id,
            room_id=room.id,
            check_in=check_in,
            check_out=check_out,
            guests=guests,
            total_cost=total_cost,
            status="Confirmed",
            payment_status="Pending",
        )
        db.session.add(reservation)
        db.session.commit()
        flash("Booking created. Payment status: Pending.", "success")
        return redirect(url_for("user_bookings"))

    check_in = request.args.get("check_in")
    check_out = request.args.get("check_out")
    return render_template(
        "book_room.html",
        user=user,
        room=room,
        check_in=check_in,
        check_out=check_out,
    )


# CANCELLATION & PAYMENT

@app.route("/user/bookings")
@login_required
def user_bookings():
    user = current_user()
    bookings = (
        Reservation.query.filter_by(user_id=user.id)
        .order_by(Reservation.created_at.desc())
        .all()
    )
    return render_template(
        "user_bookings.html", user=user, bookings=bookings, admin=current_admin()
    )


@app.route("/booking/<int:res_id>/cancel", methods=["POST"])
@login_required
def cancel_booking(res_id):
    user = current_user()
    res = Reservation.query.get_or_404(res_id)
    if res.user_id != user.id:
        flash("You can only cancel your own bookings.", "danger")
        return redirect(url_for("user_bookings"))
    res.status = "Cancelled"
    db.session.commit()
    flash("Booking cancelled.", "info")
    return redirect(url_for("user_bookings"))


@app.route("/admin/reservations")
@admin_required
def admin_reservations():
    reservations = (
        Reservation.query.order_by(Reservation.created_at.desc()).all()
    )
    return render_template(
        "admin_reservations.html",
        admin=current_admin(),
        reservations=reservations,
    )


@app.route("/admin/booking/<int:res_id>/cancel", methods=["POST"])
@admin_required
def admin_cancel_booking(res_id):
    res = Reservation.query.get_or_404(res_id)
    res.status = "Cancelled"
    db.session.commit()
    flash("Reservation cancelled by admin.", "info")
    return redirect(url_for("admin_reservations"))


@app.route("/admin/booking/<int:res_id>/payment", methods=["POST"])
@admin_required
def update_payment_status(res_id):
    res = Reservation.query.get_or_404(res_id)
    res.payment_status = request.form["payment_status"]
    db.session.commit()
    flash("Payment status updated.", "success")
    return redirect(url_for("admin_reservations"))


# REST API ENDPOINTS (for separate frontend or AJAX calls)

@app.route("/api/rooms", methods=["GET"])
def api_get_rooms():
    """Get all rooms as JSON"""
    rooms = Room.query.all()
    return jsonify([{
        "id": room.id,
        "room_number": room.room_number,
        "room_type": room.room_type,
        "price_per_night": room.price_per_night,
        "capacity": room.capacity,
        "status": room.status,
        "facilities": [rf.facility.name for rf in room.room_facilities]
    } for room in rooms])


@app.route("/api/rooms/search", methods=["POST"])
def api_search_rooms():
    """Search available rooms by date range and filters"""
    data = request.get_json()
    check_in = date.fromisoformat(data.get("check_in"))
    check_out = date.fromisoformat(data.get("check_out"))
    room_type = data.get("room_type", "").strip()
    min_price = data.get("min_price")
    max_price = data.get("max_price")
    
    q = Room.query.filter(Room.status != "Maintenance")
    if room_type:
        q = q.filter(Room.room_type == room_type)
    if min_price:
        q = q.filter(Room.price_per_night >= float(min_price))
    if max_price:
        q = q.filter(Room.price_per_night <= float(max_price))
    
    candidate_rooms = q.all()
    available_rooms = []
    
    for room in candidate_rooms:
        conflicts = (
            Reservation.query.filter(
                Reservation.room_id == room.id,
                Reservation.status == "Confirmed",
            )
            .filter(
                Reservation.check_in < check_out,
                check_in < Reservation.check_out,
            )
            .count()
        )
        if conflicts == 0:
            available_rooms.append({
                "id": room.id,
                "room_number": room.room_number,
                "room_type": room.room_type,
                "price_per_night": room.price_per_night,
                "capacity": room.capacity,
                "facilities": [rf.facility.name for rf in room.room_facilities]
            })
    
    return jsonify({"rooms": available_rooms})


@app.route("/api/bookings", methods=["POST"])
def api_create_booking():
    """Create a new booking via API"""
    data = request.get_json()
    
    # Check authentication (you can use session or API tokens)
    if "user_id" not in session:
        return jsonify({"error": "Authentication required"}), 401
    
    user_id = session["user_id"]
    room_id = data.get("room_id")
    check_in = date.fromisoformat(data.get("check_in"))
    check_out = date.fromisoformat(data.get("check_out"))
    guests = int(data.get("guests"))
    
    room = Room.query.get_or_404(room_id)
    
    if guests > room.capacity:
        return jsonify({"error": "Number of guests exceeds room capacity"}), 400
    
    # Conflict check
    conflicts = (
        Reservation.query.filter(
            Reservation.room_id == room.id,
            Reservation.status == "Confirmed",
        )
        .filter(
            Reservation.check_in < check_out,
            check_in < Reservation.check_out,
        )
        .count()
    )
    
    if conflicts > 0:
        return jsonify({"error": "Room is not available for the selected dates"}), 400
    
    nights = (check_out - check_in).days
    total_cost = nights * room.price_per_night
    
    reservation = Reservation(
        user_id=user_id,
        room_id=room.id,
        check_in=check_in,
        check_out=check_out,
        guests=guests,
        total_cost=total_cost,
        status="Confirmed",
        payment_status="Pending",
    )
    db.session.add(reservation)
    db.session.commit()
    
    return jsonify({
        "success": True,
        "reservation_id": reservation.id,
        "total_cost": total_cost,
        "nights": nights
    }), 201


@app.route("/api/bookings/<int:user_id>", methods=["GET"])
def api_get_user_bookings(user_id):
    """Get all bookings for a user"""
    if "user_id" not in session or session["user_id"] != user_id:
        return jsonify({"error": "Unauthorized"}), 403
    
    bookings = (
        Reservation.query.filter_by(user_id=user_id)
        .order_by(Reservation.created_at.desc())
        .all()
    )
    
    return jsonify([{
        "id": booking.id,
        "room_number": booking.room.room_number,
        "room_type": booking.room.room_type,
        "check_in": booking.check_in.isoformat(),
        "check_out": booking.check_out.isoformat(),
        "guests": booking.guests,
        "status": booking.status,
        "total_cost": booking.total_cost,
        "payment_status": booking.payment_status,
        "created_at": booking.created_at.isoformat()
    } for booking in bookings])


@app.route("/api/auth/login", methods=["POST"])
def api_login():
    """User login via API"""
    data = request.get_json()
    username = data.get("username", "").strip()
    password = data.get("password")
    
    user = User.query.filter_by(username=username).first()
    if not user or not check_password_hash(user.password_hash, password):
        return jsonify({"error": "Invalid username or password"}), 401
    
    session.clear()
    session["user_id"] = user.id
    
    return jsonify({
        "success": True,
        "user": {
            "id": user.id,
            "username": user.username,
            "full_name": user.full_name,
            "email": user.email
        }
    })


@app.route("/api/auth/register", methods=["POST"])
def api_register():
    """User registration via API"""
    data = request.get_json()
    username = data.get("username", "").strip()
    full_name = data.get("full_name", "").strip()
    email = data.get("email", "").strip()
    password = data.get("password")
    
    if User.query.filter(
        (User.username == username) | (User.email == email)
    ).first():
        return jsonify({"error": "Username or email already exists"}), 400
    
    user = User(
        username=username,
        full_name=full_name,
        email=email,
        password_hash=generate_password_hash(password),
    )
    db.session.add(user)
    db.session.commit()
    
    return jsonify({
        "success": True,
        "message": "Registration successful",
        "user_id": user.id
    }), 201


if __name__ == "__main__":
    with app.app_context():
        init_db()
    app.run(debug=True)
