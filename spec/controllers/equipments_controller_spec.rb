require 'rails_helper'

RSpec.describe Equipment, :type => :request do
  
  describe "get index" do
    it 'rejects unsigned user' do
        equipment = Equipment.create(name:"test", description:"test", available:true)
        get equipments_path
        expect(response).to_not be_successful 
    end

    it 'can be routed' do
        user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
        sign_in user
        equipment = Equipment.create(name:"test", description:"test", available:true)
        get equipments_path
        expect(response).to be_successful 
    end
  end

  describe "get show" do
    it 'rejects unsigned user' do
      equipment = Equipment.create(name:"test", description:"test", available:true)
      get equipment_path(equipment)
      expect(response).to_not be_successful 
    end

    it 'can be routed' do
        user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
        sign_in user
        equipment = Equipment.create(name:"test", description:"test", available:true)
        get equipment_path(equipment)
        expect(response).to be_successful 
    end
  end

  describe "get new" do
    it 'rejects unsigned user' do
      equipment = Equipment.create(name:"test", description:"test", available:true)
      get new_equipment_path
      expect(response).to_not be_successful 
    end

    it 'can be routed' do
      user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
      sign_in user
      get new_equipment_path
      expect(response).to be_successful 
    end
  end

  describe "get edit" do
    it 'rejects unsigned user' do
      equipment = Equipment.create(name:"test", description:"test", available:true)
      get edit_equipment_path(equipment)
      expect(response).to_not be_successful 
    end

    it 'can be routed' do
      user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
      sign_in user
      equipment = Equipment.create(name:"test", description:"test", available:true)
      get edit_equipment_path(equipment)
      expect(response).to be_successful 
    end
  end

  describe "post create" do
    it 'rejects unsigned user' do
      expect do 
        post equipments_url, params:{:equipment => {:name =>"test", :description => "test", :available => true}}
      end.to change(Equipment, :count).by(0)
    end

    context 'with valid params' do
      it 'creates a new equipment' do
        user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
        sign_in user
        expect do 
          post equipments_url, params:{:equipment => {:name =>"test", :description => "test", :available => true}}
        end.to change(Equipment, :count).by(1)
      end

      it 'redirects to index' do
        user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
        sign_in user
        post equipments_url, params:{:equipment => {:name =>"test", :description => "test", :available => true}}
        expect(response).to redirect_to(equipments_url)
      end
    end

    context 'with invalid params' do
      it 'does not create new equipment' do
        user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
        sign_in user
        expect do 
          post equipments_url, params:{:equipment => {:description => "test", :available => true}}
        end.to change(Equipment, :count).by(0)
      end

      it 'renders edit page' do
        user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
        sign_in user
        post equipments_url, params:{:equipment => {:description => "test", :available => true}}
        expect(response).to be_successful
      end
    end

  describe "patch update" do
    it 'rejects unsigned user' do
      equipment = Equipment.create(name:"test", description:"test", available:true)
        patch equipment_url(equipment), params:{:equipment => {:name =>"test change", :description => "test", :available => true}}
        equipment.reload
        expect(equipment.name).to_not eq "test change"
    end

    context 'with valid params' do
      it 'creates a new equipment' do
        user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
        sign_in user
        equipment = Equipment.create(name:"test", description:"test", available:true)
        patch equipment_url(equipment), params:{:equipment => {:name =>"test change", :description => "test", :available => true}}
        equipment.reload
        expect(equipment.name).to eq "test change"
      end

      it 'redirects to index' do
        user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
        sign_in user
        equipment = Equipment.create(name:"test", description:"test", available:true)
        patch equipment_url(equipment), params:{:equipment => {:name =>"test change", :description => "test", :available => true}}
        equipment.reload
        expect(response).to redirect_to(equipment_url(equipment))
      end
    end

    context 'with invalid params' do
      it 'does not create a new equipment' do
        user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
        sign_in user
        equipment = Equipment.create(name:"test", description:"test", available:true)
        patch equipment_url(equipment), params:{:equipment => {:name =>nil, :description => "test", :available => true}}
        equipment.reload
        expect(equipment.name).to eq "test"
      end

      it 'redirects to edit' do
        user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
        sign_in user
        equipment = Equipment.create(name:"test", description:"test", available:true)
        patch equipment_url(equipment), params:{:equipment => {:name =>nil, :description => "test", :available => true}}
        equipment.reload
        expect(response).to be_successful
      end
    end

  end

  describe "delete equipent" do
    it 'rejects unsigned user' do
      equipment = Equipment.create(name:"test", description:"test", available:true)
      expect do
        delete equipment_url(equipment)
      end.to change(Equipment, :count).by(0)
    end

    it 'deletes the equipment' do
      user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
      sign_in user
      equipment = Equipment.create(name:"test", description:"test", available:true)
      expect do
        delete equipment_url(equipment)
      end.to change(Equipment, :count).by(-1)
    end
  end

  describe "get delete" do
    it 'rejects unsigned user' do
      equipment = Equipment.create(name:"test", description:"test", available:true)
      get delete_equipment_path(equipment)
      expect(response).to_not be_successful
    end

    it 'can be routed' do
      user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
      sign_in user
      equipment = Equipment.create(name:"test", description:"test", available:true)
      get delete_equipment_path(equipment)
      expect(response).to be_successful
    end

    
  end

  describe "get equip_list" do
    it 'rejects unsigned user' do
      get '/equipments/equip_list'
      expect(response).to_not be_successful
    end

    it 'can be routed' do
      user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
      sign_in user
      get '/equipments/equip_list'
      expect(response).to be_successful
    end

    
  end
  
  describe "get equip_list" do
    it 'rejects unsigned user' do
      equipment = Equipment.create(name:"test", description:"test", available:true)
      get show_for_members_equipment_path(equipment)
      expect(response).to_not be_successful
    end

    it 'can be routed' do
      user = Account.create(email: 'test@test.com', password: "password", password_confirmation: "password")
      sign_in user
      equipment = Equipment.create(name:"test", description:"test", available:true)
      get show_for_members_equipment_path(equipment)
      expect(response).to be_successful
    end

    
  end

  describe "get check_out" do
    it 'rejects unsigned user' do
      equipment = Equipment.create(name:"test", description:"test", available:true)
      get check_out_equipment_path(equipment)
      equipment.reload
      expect(equipment.available).to_not eq false
    end

    it 'can check out' do
      user = Account.create(first_name: "test", last_name: "test", email: 'test@test.com', password: "password", password_confirmation: "password")
      sign_in user
      equipment = Equipment.create(name:"test", description:"test", available:true)
      get check_out_equipment_path(equipment)
      equipment.reload
      expect(equipment.available).to eq false
    end
    
    
  end

  describe "get check_in" do
    it 'rejects unsigned user' do
      equipment = Equipment.create(name:"test", description:"test", available:false)
      get check_in_equipment_path(equipment)
      equipment.reload
      expect(equipment.available).to_not eq true
    end

    it 'can check out' do
      user = Account.create(first_name: "test", last_name: "test", email: 'test@test.com', password: "password", password_confirmation: "password")
      sign_in user
      equipment = Equipment.create(name:"test", description:"test", available:false)
      get check_in_equipment_path(equipment)
      equipment.reload
      expect(equipment.available).to eq true
    end
    
    
  end




  
  end

end