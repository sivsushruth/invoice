defmodule Invoice.FileUtil do
  def get_promotions(file \\ "data/promotions.json") do
    file
    |> get_json()
    |> Map.new(fn p -> 
      {p["id"], Map.new(p["discount"], fn {k, v} -> {String.to_atom(k), v} end)}
    end)
  end

  def get_inventory(file \\ "data/products.json") do
    file
    |> get_json()
    |> Map.new(fn p -> 
      {p["code"], 
        %Invoice.Product{
          code: p["code"],
          name: p["name"],
          promotion_id: p["promotion_id"],
          price: p["price"]
        }
      }
    end)
  end

  defp get_json(filename) do
    filename
    |> File.read!()
    |> Poison.decode!()
  end
end