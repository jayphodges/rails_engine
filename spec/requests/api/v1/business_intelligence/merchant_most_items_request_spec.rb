require 'rails_helper'

describe "Merchant BI most_items API" do
  it "sends a list of the merchants that sold the most items" do
    customer = create(:customer)
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)
    item3 = create(:item, merchant: merchant3)
    invoice1 = create(:invoice, customer: customer, merchant: merchant1)
    invoice2 = create(:invoice, customer: customer, merchant: merchant2)
    invoice3 = create(:invoice, customer: customer, merchant: merchant3)
    create(:transaction, invoice: invoice1, result: 'success')
    create(:transaction, invoice: invoice2, result: 'success')
    create(:transaction, invoice: invoice3, result: 'failed')
    create(:invoice_item, invoice: invoice1, item: item1, quantity: 10)
    create(:invoice_item, invoice: invoice2, item: item2, quantity: 5)
    create(:invoice_item, invoice: invoice3, item: item3, quantity: 20)


    get '/api/v1/merchants/most_items?quantity=3'

    merchants = JSON.parse(response.body)

    expect(response).to be_success
    expect(merchants.count).to eq(2)
    expect(merchants.first["id"]).to eq(merchant1.id)
    expect(merchants.second["id"]).to eq(merchant2.id)
  end


end
