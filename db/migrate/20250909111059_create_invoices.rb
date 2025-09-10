class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.string :customer_name
      t.decimal :total_price
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
