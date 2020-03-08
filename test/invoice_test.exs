defmodule InvoiceTest do
  use ExUnit.Case
  doctest Invoice
  alias Invoice.ScannerHelper
  @test_data_dir "test/data"
  @test_products "#{@test_data_dir}/products.json"
  @test_promotions "#{@test_data_dir}/promotions.json"

  test "Scan 1 Discounted Price" do
    invoice = ScannerHelper.run(scans_file(1), @test_products, @test_promotions)
    assert invoice.discounted_price == 32.50
  end

  test "Scan 1 Bill Items" do
    invoice = ScannerHelper.run(scans_file(1), @test_products, @test_promotions)
    assert Enum.count(invoice.bill_items) == 3
  end

  test "Scan 2 Discounted Price" do
    invoice = ScannerHelper.run(scans_file(2), @test_products, @test_promotions)
    assert invoice.discounted_price == 30.00
  end
  
  test "Scan 3 Discounted Price" do
    invoice = ScannerHelper.run(scans_file(3), @test_products, @test_promotions)
    assert invoice.discounted_price == 81.00
  end

  test "Scan 3 Bill Items" do
    invoice = ScannerHelper.run(scans_file(3), @test_products, @test_promotions)
    assert Enum.count(invoice.bill_items) == 2
  end
  
  test "Scan 4" do
    invoice = ScannerHelper.run(scans_file(4), @test_products, @test_promotions)
    assert invoice.discounted_price == 74.50
  end

  defp scans_file(id) do
    "#{@test_data_dir}/scans_#{id}.csv"
  end
end
