defmodule Peredacha.Auth.LoginForm do
  use Ecto.Schema
  import Ecto.Changeset

  # 1. Define the structure of the form inputs
  embedded_schema do
    field :email, :string
    field :password, :string
  end

  # 2. Define the validation logic
  def changeset(form, attrs) do
    form
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password], message: "це поле обов'язкове")
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "невірний формат email")
    |> validate_length(:password, min: 6, message: "мінімум 6 символів")
  end
end
