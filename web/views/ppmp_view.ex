defmodule Oppcis.PPMPView do
  use Oppcis.Web, :view

  def categories do
    [
      "Accountable Forms Expenses",
      "Advertising Expenses"
    ]
  end

  def procurement_modes do
    [
      "Public Bidding"
    ]
  end

  def procurement_types do
    ~w(Goods Infra Consulting)
  end

  def contract_types do
    ["Contracted out", "By Administration", "Contracted Out - Ordering Agrement", "Consignment"]
  end

  def funding_choices do
    ["GOP - RA-9184", "Foreign-funded RA-9184", "Foreign-funded - Other governing rules/guidelines"]
  end

  def measurement_units do
    ["Ampoule", "Bag", "Bale", "Bar", "Ball", "Barrel"]
  end
end
