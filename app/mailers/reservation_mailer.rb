class ReservationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_mailer.item_reservation.subject
  #
  def item_reservation(equipment, reservation, account)
    @equipment = equipment
    @reservation = reservation
    @name = account.first_name
    
    mail to: account.email,
         subject: "You Made A Reservation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_mailer.overdue_reservation.subject
  #
  def overdue_reservation
    @equipment = equipment.name
    @name = account.first_name

    mail to: account.email, subject: "You have checked out an item"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_mailer.checkin_reservation.subject
  #
  def checkin_reservation(equipment, account)
    @equipment = equipment
    @name = account.first_name

    mail to: account.email, subject: "You have checked in an item"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_mailer.checkout_reservation.subject
  #
  def checkout_reservation(equipment, account)
    @equipment = equipment
    @name = account.first_name

    mail to: account.email, subject: "You have checked out an item"
  end
end
