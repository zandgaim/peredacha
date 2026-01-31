defmodule Peredacha.Cars do
  # У реальному проекті тут будуть Ecto запити: Repo.all(...)

  def list_makes do
    [
      %{id: "renault", name: "Renault"},
      %{id: "opel", name: "Opel"},
      %{id: "nissan", name: "Nissan"}
    ]
  end

  def list_models(make_id) do
    case make_id do
      "renault" ->
        [
          %{id: "trafic_2", name: "Trafic II (2001-2014)"},
          %{id: "master_3", name: "Master III (2010-2024)"},
          %{id: "kangoo_2", name: "Kangoo II"}
        ]

      "opel" ->
        [
          %{id: "vivaro_a", name: "Vivaro A"},
          %{id: "movano_b", name: "Movano B"}
        ]

      "nissan" ->
        [
          %{id: "primastar", name: "Primastar"},
          %{id: "nv400", name: "NV400"}
        ]

      _ ->
        []
    end
  end

  def list_engines(model_id) do
    # Для трансмісії важливий об'єм і тип палива, бо коробки різні
    case model_id do
      "trafic_2" ->
        [
          %{id: "1.9_dci", name: "1.9 dCi (F9Q)"},
          %{id: "2.0_dci", name: "2.0 dCi (M9R)"},
          %{id: "2.5_dci", name: "2.5 dCi (G9U)"}
        ]

      "master_3" ->
        [
          %{id: "2.3_dci_fwd", name: "2.3 dCi (FWD)"},
          # Задній привід - інша коробка!
          %{id: "2.3_dci_rwd", name: "2.3 dCi (RWD)"}
        ]

      _ ->
        [
          %{id: "std", name: "Стандартна комплектація"}
        ]
    end
  end
end
