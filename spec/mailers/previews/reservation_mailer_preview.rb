# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview

    # Preview this email at http://localhost:3000/rails/mailers/reservation_mailer/item_reservation
    def item_reservation
      ReservationMailer.item_reservation
    end
  
    # Preview this email at http://localhost:3000/rails/mailers/reservation_mailer/overdue_reservation
    def overdue_reservation
      ReservationMailer.overdue_reservation
    end
  
    # Preview this email at http://localhost:3000/rails/mailers/reservation_mailer/checkin_reservation
    def checkin_reservation
      ReservationMailer.checkin_reservation
    end
  
    # Preview this email at http://localhost:3000/rails/mailers/reservation_mailer/checkout_reservation
    def checkout_reservation
      ReservationMailer.checkout_reservation
    end
end
