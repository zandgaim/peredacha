defmodule PeredachaWeb.Router do
  use PeredachaWeb, :router

  alias PeredachaWeb.Live.RestoreTheme
  alias PeredachaWeb.Hooks.RestoreUser
  alias PeredachaWeb.Hooks.RequireLogin

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PeredachaWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_cookies

    plug PeredachaWeb.Plugs.FetchUser
    plug PeredachaWeb.Plugs.SetLocale
    plug PeredachaWeb.Plugs.ThemePlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PeredachaWeb do
    pipe_through :browser

    # --- Auth HTTP Routes ---
    post "/auth/login_success", AuthController, :login_success
    get "/auth/logout", AuthController, :logout
    get "/auth/refresh", AuthController, :refresh

    # --- ГРУПА: ПУБЛІЧНІ СТОРІНКИ ---
    # RestoreUser гарантує наявність @current_user у сокеті
    live_session :default, on_mount: [RestoreTheme, RestoreUser] do
      live "/", Pages.MainPage
    end

    # --- ГРУПА: ТІЛЬКИ ДЛЯ ГОСТЕЙ ---
    live_session :guest,
      on_mount: [
        RestoreTheme,
        RestoreUser,
        {RequireLogin, :redirect_if_authenticated}
      ] do
      live "/auth", Pages.AuthPage
    end

    # --- ГРУПА: ЗАХИЩЕНІ СТОРІНКИ ---
    live_session :authenticated,
      on_mount: [
        RestoreTheme,
        RestoreUser,
        {RequireLogin, :ensure_authenticated}
      ] do
      live "/blog", Pages.BlogPage
      live "/blog/:slug", Pages.BlogArticlePage
      # live "/profile", Pages.ProfilePage
    end
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:peredacha, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PeredachaWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
