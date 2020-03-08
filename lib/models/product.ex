defmodule Invoice.Product do
  defstruct [:name , :price, :code, :promotion_id]

  @type product :: %__MODULE__{
    name: String.t,
    price: Float.t,
    code: String.t,
    promotion_id: Integer.t
  }

  def get_product_by_code(code, inventory) do
    Map.get(inventory, code)
  end

end