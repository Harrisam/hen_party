module ProductsHelper

  def format_price(page)
    total = number_to_currency((page.price + page.pnp), precision: 2)

    if page.pnp > 0
      pnp = number_to_currency(page.pnp, precision: 2)
    else
      pnp = "free P&P"
    end

    "#{total} (inc. #{pnp})"
  end
end
