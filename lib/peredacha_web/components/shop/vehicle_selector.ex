defmodule PeredachaWeb.Components.Shop.VehicleSelector do
  use PeredachaWeb, :live_component
  alias Peredacha.Cars

  @impl true
  def mount(socket) do
    # Ініціалізація: завантажуємо лише Марки
    socket =
      socket
      |> assign(:makes, Cars.list_makes())
      |> assign(:models, [])
      |> assign(:engines, [])
      |> assign(:selected_make, "")
      |> assign(:selected_model, "")
      |> assign(:selected_engine, "")
      |> assign(:can_submit, false)

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="vehicle-selector-wrapper">
      <form
        phx-change="filter_changed"
        phx-submit="search_parts"
        phx-target={@myself}
        class="grid grid-cols-1 md:grid-cols-4 gap-4 items-end"
      >
        <% # 1. MAKE SELECT %>
        <div class="flex flex-col gap-1">
          <label class="text-xs font-bold text-gray-500 uppercase tracking-wide">Марка</label>
          <select
            name="make"
            class="block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm py-2.5"
          >
            <option value="">Оберіть марку</option>
            <%= for make <- @makes do %>
              <option value={make.id} selected={@selected_make == make.id}>{make.name}</option>
            <% end %>
          </select>
        </div>

        <% # 2. MODEL SELECT (Disabled until Make is chosen) %>
        <div class="flex flex-col gap-1">
          <label class="text-xs font-bold text-gray-500 uppercase tracking-wide">Модель</label>
          <select
            name="model"
            disabled={@models == []}
            class={"block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm py-2.5 #{if @models == [], do: "bg-gray-100 text-gray-400 cursor-not-allowed"}"}
          >
            <option value="">Оберіть модель</option>
            <%= for model <- @models do %>
              <option value={model.id} selected={@selected_model == model.id}>{model.name}</option>
            <% end %>
          </select>
        </div>

        <% # 3. ENGINE/MODIFICATION SELECT (Disabled until Model is chosen) %>
        <div class="flex flex-col gap-1">
          <label class="text-xs font-bold text-gray-500 uppercase tracking-wide">Двигун / Рік</label>
          <select
            name="engine"
            disabled={@engines == []}
            class={"block w-full rounded-md border-gray-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm py-2.5 #{if @engines == [], do: "bg-gray-100 text-gray-400 cursor-not-allowed"}"}
          >
            <option value="">Оберіть двигун</option>
            <%= for engine <- @engines do %>
              <option value={engine.id} selected={@selected_engine == engine.id}>
                {engine.name}
              </option>
            <% end %>
          </select>
        </div>

        <% # 4. SUBMIT BUTTON %>
        <button
          type="submit"
          disabled={not @can_submit}
          class={"w-full flex justify-center items-center gap-2 py-2.5 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white transition-all
            #{if @can_submit, do: "bg-blue-600 hover:bg-blue-700 focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 shadow-lg hover:-translate-y-0.5", else: "bg-gray-400 cursor-not-allowed"}
          "}
        >
          <span>🔍 Знайти запчастини</span>
        </button>
      </form>

      <% # Optional: Quick Garage Link (UX Bonus) %>
      <div class="mt-4 flex items-center justify-between text-xs text-gray-500 border-t border-gray-100 pt-3">
        <span>
          Або увійдіть в <a href="#" class="text-blue-600 underline">Гараж</a>, щоб вибрати збережене авто.
        </span>
        <%= if @can_submit do %>
          <span class="text-green-600 font-medium flex items-center gap-1">
            ✓ Авто обрано: {String.upcase(@selected_make)}
          </span>
        <% end %>
      </div>
    </div>
    """
  end

  # Обробка змін у формі
  # _target - це список ключів, що вказує, який саме input змінився ["make"] або ["model"]
  @impl true
  def handle_event("filter_changed", params, socket) do
    target = params["_target"] || []

    socket =
      cond do
        # 1. Змінилась МАРКА
        "make" in target ->
          new_make = params["make"]
          models = if new_make != "", do: Cars.list_models(new_make), else: []

          socket
          |> assign(:selected_make, new_make)
          |> assign(:models, models)
          # Скидаємо все, що нижче по ієрархії
          |> assign(:selected_model, "")
          |> assign(:engines, [])
          |> assign(:selected_engine, "")
          |> assign(:can_submit, false)

        # 2. Змінилась МОДЕЛЬ
        "model" in target ->
          new_model = params["model"]
          engines = if new_model != "", do: Cars.list_engines(new_model), else: []

          socket
          |> assign(:selected_model, new_model)
          |> assign(:engines, engines)
          # Скидаємо двигун
          |> assign(:selected_engine, "")
          |> assign(:can_submit, false)

        # 3. Змінився ДВИГУН
        "engine" in target ->
          new_engine = params["engine"]

          socket
          |> assign(:selected_engine, new_engine)
          |> assign(:can_submit, new_engine != "")

        true ->
          socket
      end

    {:noreply, socket}
  end

  # Обробка кліку "Знайти"
  @impl true
  def handle_event("search_parts", _params, socket) do
    # Формуємо URL для редіректу
    # Наприклад: /shop/catalog?make=renault&model=trafic_2&engine=2.0_dci
    query_params = %{
      make: socket.assigns.selected_make,
      model: socket.assigns.selected_model,
      engine: socket.assigns.selected_engine
    }

    # Використовуємо push_navigate для переходу на сторінку каталогу
    {:noreply, push_navigate(socket, to: ~p"/shop/catalog?#{query_params}")}
  end
end
