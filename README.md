# Invoice

### Example

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

### Setup 
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

### Tests

```
  mix test
```

### Installation

The [package](https://hex.pm/docs/publish) can be installed by adding `Invoice` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:invoice, "~> 0.0.1"}]
end
```

The docs can be found at [https://hexdocs.pm/invoice](https://hexdocs.pm/invoice).

