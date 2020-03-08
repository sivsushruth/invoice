defmodule Invoice.Bill do
  alias Invoice.BillItem
  alias Invoice.Product

  @doc """
  Updates the invoice with the bill value
  """
  @spec update_bill(Invoice.Invoice, Map.t) :: Invoice.Invoice
  def update_bill(%Invoice{} = invoice, promotions) do
    bill_items = invoice.products
    |> Enum.group_by(&(&1))
    |> Enum.map(fn {%Product{} = product, products} ->
      quantity = Enum.count(products)
      original_price = product.price * quantity
      %BillItem{
        product: product, 
        quantity: quantity, 
        original_price: original_price,
        discounted_price: original_price,
      }
      |> apply_discount(product, promotions)
    end)
    {original_price, discounted_price} = Enum.reduce(bill_items, {0, 0}, fn %BillItem{original_price: op, discounted_price: dp}, {original_price, discounted_price} ->
      {op + original_price, discounted_price + dp}
    end)
    %Invoice{invoice | original_price: original_price, discounted_price: discounted_price, bill_items: bill_items}
  end


  def apply_discount(%BillItem{} = bill_item, %Product{promotion_id: nil}, _promotions), do: bill_item

  def apply_discount(%BillItem{} = bill_item, %Product{promotion_id: promotion_id}, promotions) do
    promotion = Map.get(promotions, promotion_id)
    apply_discount(bill_item, promotion)
  end

  @doc """
    Apply discount when no promotion is of type 'Buy 2 Get 1 Free' or 'Get product at x% off if more than y items in cart'
    ```
      apply_discount(%{BillItem.bill_item{}, %{every: 2, free: 1})  
      apply_discount(%BillItem.bill_item{}, %{minimum_quantity: 3, rate_reduction: 0.95})  
    ```
  """
  def apply_discount(%BillItem{quantity: quantity, product: product} = bill_item, %{every: every, free: free}) do
    %BillItem{bill_item | discounted_price: Float.round(payable_quantity(quantity, every, free) * product.price)}
  end

  def apply_discount(%BillItem{quantity: quantity, original_price: original_price} = bill_item, %{minimum_quantity: minimum_quantity, rate_reduction: rate_reduction}) when quantity >= minimum_quantity do
    %BillItem{bill_item | discounted_price: Float.round(original_price * rate_reduction, 2)}
  end

  def apply_discount(%BillItem{} = bill_item, _), do: bill_item

  @spec payable_quantity(Integer.t, Integer.t, Integer.t) :: Integer.t
  def payable_quantity(total_quantity, every, free) when every != 0 do
    # r = rem(n, x + y)
    # (div(n, x + y) * x) + (((r > x) && x) || r)
    Float.ceil((total_quantity * every)/(every + free))
  end

end