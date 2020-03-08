defmodule Invoice.BillItem do
  defstruct [:discounted_price, :original_price, :quantity, product: %Invoice.Product{}]

  @type bill_item :: %__MODULE__{
    discounted_price: Float.t,
    original_price: Float.t,
    product: Invoice.Product.product,
    quantity: Integer.t,
    original_price: Integer.t
  }

end