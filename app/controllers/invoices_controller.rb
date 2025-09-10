class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]

  def index
    @invoices = Invoice.order(created_at: :desc)
  end

  def show
  end

  def new
    @invoice = Invoice.new
    @invoice.invoice_items.build
  end

  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      redirect_to @invoice, notice: "Invoice created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @invoice.update(invoice_params)
      redirect_to invoices_path, notice: "Invoice updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy
    redirect_to invoices_path, notice: "Invoice deleted successfully."
  end

  # AJAX search for items
  def search_items
    @items = Item.where("name ILIKE ?", "%#{params[:q]}%").limit(10)
    render partial: "items_list", locals: { items: @items }
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(
      :customer_name,
      invoice_items_attributes: [:item_id, :quantity, :price, :_destroy]
    )
  end
end
