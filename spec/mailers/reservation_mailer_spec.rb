require "rails_helper"

RSpec.describe ReservationMailer, type: :mailer do
  describe "item_reservation" do
    let(:mail) { ReservationMailer.item_reservation }

    it "renders the headers" do
      expect(mail.subject).to eq("Item reservation")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "overdue_reservation" do
    let(:mail) { ReservationMailer.overdue_reservation }

    it "renders the headers" do
      expect(mail.subject).to eq("Overdue reservation")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "checkin_reservation" do
    let(:mail) { ReservationMailer.checkin_reservation }

    it "renders the headers" do
      expect(mail.subject).to eq("Checkin reservation")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "checkout_reservation" do
    let(:mail) { ReservationMailer.checkout_reservation }

    it "renders the headers" do
      expect(mail.subject).to eq("Checkout reservation")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
