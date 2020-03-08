defmodule Invoice do
  @moduledoc """

  ```
  promotions = Invoice.FileUtil.get_promotions()
  inventory = Invoice.FileUtil.get_inventory()

  Invoice.new_invoice()
  |> Invoice.Scanner.add_product!("MUG", inventory)
  |> Invoice.Scanner.add_product!("TSHIRT", inventory)
  |> Invoice.Scanner.add_product!("VOUCHER", inventory)
  |> Invoice.Scanner.remove_product!("VOUCHER")
  |> Invoice.Bill.update_bill(promotions)
  ```

  Add products to **data/products.json** in the format give below

  ```
  [
    {
      "name": "Invoice Coffee Mug",
      "code": "MUG",
      "price": 7.5
    },
    {
      "name": "Invoice T-Shirt",
      "code": "TSHIRT",
      "promotion_id": 2,
      "price": 20
    },
    {
      "name": "Invoice Voucher",
      "code": "VOUCHER",
      "price": 5,
      "promotion_id": 1 
    }
  ]

  ```

  Add promotions to **data/promotions.json** in the format give below

  ```
  [
    {
      "id": 1,
      "discount": {
        "every": 2,
        "free": 1
      }
    },
    {
      "id": 2,
      "discount": {
        "minimum_quantity": 2,
        "rate_reduction": 0.95
      }
    }
  ]
  ```

  """

  defstruct [:currency, products: [], original_price: 0, discounted_price: 0, bill_items: []]

  @type invoice :: %__MODULE__{
    currency: String.t,
    discounted_price: Float.t,
    original_price: Float.t,
    bill_items: list(Invoice.BillItem.bill_item),
    products: list(Invoice.Product.product)
  }

  @doc """
  Generates a blank invoice
  """

  #TODO: Ability to add or generate and invoice number
  def new_invoice(currency \\ "EUR") do
    %__MODULE__{currency: currency}
  end

end
