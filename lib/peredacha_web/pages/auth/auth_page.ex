defmodule PeredachaWeb.Pages.AuthPage do
  use PeredachaWeb, :live_view

  alias Peredacha.CoreApiClient
  alias Peredacha.Auth.LoginForm

  def mount(_params, session, socket) do
    changeset = LoginForm.changeset(%LoginForm{}, %{})

    {:ok,
     socket
     |> assign(mode: :login)
     |> assign(form: to_form(changeset, as: "auth"))
     |> assign(access_token: nil)
     |> assign(refresh_token: nil)
     |> assign(csrf_token: session["_csrf_token"])}
  end

  def render(assigns) do
    ~H"""
    <div class="hero min-h-screen bg-base-200 font-sans">
      <div class="hero-content flex-col w-full max-w-md">
        <div class="card w-full shadow-2xl bg-base-100 border border-base-300">
          <.form for={@form} phx-change="validate" phx-submit="submit" class="card-body gap-4">
            <div class="text-center">
              <h1 class="text-3xl font-black uppercase tracking-tighter text-primary">
                {if @mode == :login, do: "Вхід у кабінет", else: "Реєстрація"}
              </h1>
              <p class="text-sm text-base-content/50">
                {if @mode == :login,
                  do: "Введіть дані вашого профілю",
                  else: "Створіть свій особистий кабінет"}
              </p>
            </div>

            <div :if={@form[:base].errors != []} class="alert alert-error text-sm py-2 rounded-lg">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="stroke-current shrink-0 h-5 w-5"
                fill="none"
                viewBox="0 0 24 24"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"
                />
              </svg>
              <span>{translate_error(List.first(@form[:base].errors))}</span>
            </div>

            <div class="form-control">
              <label class="label">
                <span class="label-text font-semibold text-base-content/70">Email</span>
              </label>
              <input
                type="email"
                name={@form[:email].name}
                value={@form[:email].value}
                class={"input input-bordered focus:input-primary transition-all #{if @form[:email].errors != [], do: "input-error"}"}
                placeholder="name@mail.com"
                required
              />
              <label :for={error <- @form[:email].errors} class="label py-0">
                <span class="label-text-alt text-error">{translate_error(error)}</span>
              </label>
            </div>

            <div class="form-control">
              <label class="label">
                <span class="label-text font-semibold text-base-content/70">Пароль</span>
              </label>
              <input
                type="password"
                name={@form[:password].name}
                value={@form[:password].value}
                class={"input input-bordered focus:input-primary transition-all #{if @form[:password].errors != [], do: "input-error"}"}
                required
              />
              <label :for={error <- @form[:password].errors} class="label py-0">
                <span class="label-text-alt text-error">{translate_error(error)}</span>
              </label>
              <label :if={@mode == :login} class="label justify-end">
                <a href="#" class="label-text-alt link link-hover text-primary font-medium">
                  Забули пароль?
                </a>
              </label>
            </div>

            <div class="form-control mt-4">
              <button
                class="btn btn-primary btn-block uppercase tracking-widest font-bold"
                phx-disable-with="Обробка..."
              >
                {if @mode == :login, do: "Увійти", else: "Створити акаунт"}
              </button>
            </div>

            <div class="divider text-[10px] text-base-content/30 uppercase font-bold tracking-widest">
              Або
            </div>

            <div class="text-center">
              <span class="text-sm text-base-content/60">
                {if @mode == :login, do: "Вперше у нас?", else: "Вже маєте акаунт?"}
              </span>
              <button
                type="button"
                phx-click="switch_mode"
                class="link link-primary text-sm font-bold ml-1 transition-all"
              >
                {if @mode == :login, do: "Зареєструватися", else: "Увійти до кабінету"}
              </button>
            </div>
          </.form>
        </div>
      </div>
    </div>
    <form id="login-form" action="/auth/login_success" method="post" style="display: none;">
      <input type="hidden" name="_csrf_token" value={Phoenix.Controller.get_csrf_token()} />
      <input type="hidden" name="access_token" value="" />
      <input type="hidden" name="refresh_token" value="" />
    </form>

    <script>
      window.addEventListener("phx:login_success", (event) => {
        const { access_token, refresh_token } = event.detail;
        document.querySelector('input[name="access_token"]').value = access_token;
        document.querySelector('input[name="refresh_token"]').value = refresh_token;
        document.getElementById('login-form').submit();
      });
    </script>
    """
  end

  def handle_event("validate", %{"auth" => params}, socket) do
    changeset =
      %LoginForm{}
      |> LoginForm.changeset(params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, form: to_form(changeset, as: "auth"))}
  end

  def handle_event("switch_mode", _params, socket) do
    new_mode = if socket.assigns.mode == :login, do: :register, else: :login
    empty_changeset = LoginForm.changeset(%LoginForm{}, %{})

    {:noreply,
     socket |> assign(mode: new_mode) |> assign(form: to_form(empty_changeset, as: "auth"))}
  end

  def handle_event("submit", %{"auth" => params}, socket) do
    changeset = LoginForm.changeset(%LoginForm{}, params)

    case Ecto.Changeset.apply_action(changeset, :insert) do
      {:ok, data} ->
        handle_auth_action(socket, data.email, data.password)

      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(changeset, as: "auth"))}
    end
  end

  defp handle_auth_action(socket, email, password) do
    result =
      case socket.assigns.mode do
        :login -> CoreApiClient.login(email, password)
        :register -> CoreApiClient.register(email, password)
      end

    case result do
      {:ok, %{"access_token" => access_token, "refresh_token" => refresh_token}} ->
        {:noreply,
         socket
         |> assign(access_token: access_token, refresh_token: refresh_token)
         |> push_event("login_success", %{
           access_token: access_token,
           refresh_token: refresh_token
         })}

      {:error, reason} ->
        changeset =
          %LoginForm{}
          |> LoginForm.changeset(%{email: email, password: password})
          |> Map.put(:action, :insert)
          |> Ecto.Changeset.add_error(:base, to_string(reason))

        {:noreply, assign(socket, form: to_form(changeset, as: "auth"))}
    end
  end
end
