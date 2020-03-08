defmodule Invoice.Scanner do
  alias Invoice.Product

  @doc """
  Raises error response from `add_product/3`
  """
  def add_product!(invoice, code, inventory) do
    case add_product(invoice, code, inventory) do
      {:ok, i} -> i
      {:error, e} -> raise e
    end
  end

  @doc """
  Adds product to the invoice
  if not present in inventory, returns 
    `{:error, "Product not found"}`
  otherwise, returns 
    `{:ok, updated_invoice}`
  """
  def add_product(invoice, code, inventory) do
    code
    |> Product.get_product_by_code(inventory)
    |> case do
      nil -> {:error, "Product not found"}
      p -> {:ok, %Invoice{invoice | products: [p] ++ invoice.products}}
    end
  end

  @doc """
  Raises error response from `remove_product/3`
  """
  def remove_product!(invoice, code) do
    case remove_product(invoice, code) do
      {:ok, i} -> i
      {:error, e} -> raise e
    end
  end

  @doc """
  Removes one quanity of product from invoice
  if not present in invoice, returns 
    `{:error, "Product not added"}`
  otherwise, returns 
    `{:ok, updated_invoice}`
  """
  def remove_product(invoice, code) do
    invoice.products
    |> Enum.find_index(&(&1.code == code))
    |> case do
      nil -> {:error, "Product not added"}
      i -> {:ok, %Invoice{invoice | products: List.delete_at(invoice.products, i)}}
    end
  end

end