defmodule Invoice.ScannerHelper do
  @doc """
    Actions performed by scanner can be stored in a CSV like
    ```
    ADD VOUCHER
    ADD TSHIRT
    ADD VOUCHER
    ADD VOUCHER
    ADD MUG
    ADD TSHIRT
    ADD TSHIRT
    ```
    
    ```
    Invoice.ScannerHelper.run("scans.csv", "products.json", "promotions.json")
    ```
  """
  def run(actions_file, inventory_file, promotions_file) when is_binary(actions_file) do
    actions_file
    |> File.read!()
    |> String.split("\n")
    |> run(inventory_file, promotions_file)
  end

  def run(csv, inventory_file, promotions_file) when is_list(csv) do
    inventory = Invoice.FileUtil.get_inventory(inventory_file)
    promotions = Invoice.FileUtil.get_promotions(promotions_file)
    invoice = Invoice.new_invoice()
    csv
    |> Enum.map(fn l ->
      String.split(l, " ", trim: true)
    end)
    |> Enum.reduce(invoice, fn [action, code], invoice ->
      case action do
        "ADD" -> Invoice.Scanner.add_product!(invoice, code, inventory)
        "REMOVE" -> Invoice.Scanner.remove_product!(invoice, code)
      end
    end)
    |> Invoice.Bill.update_bill(promotions)
  end

end