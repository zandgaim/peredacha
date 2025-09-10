defmodule PeredachaWeb.Components.Footer do
  use PeredachaWeb, :live_component

  alias PeredachaWeb.Components.SocialIcons

  def render(assigns) do
    ~H"""
    <footer class="bg-yellow-500 footer footer-horizontal footer-center bg-primary text-primary-content p-10">
      <aside>
        <img
          src={PeredachaWeb.Endpoint.static_path("/images/logo_5p_white.png")}
          width="50"
          height="50"
          viewBox="0 0 24 24"
          alt="5peredacha Logo"
          fill-rule="evenodd"
          clip-rule="evenodd"
          class="inline-block fill-current"
        />
        <p class="font-bold">
          5 Передача <br /> CТО по ремонту КПП Renault
        </p>
        
        <p>Copyright © {DateTime.utc_now().year}. Всі права захищено.</p>
      </aside>
       <.live_component module={SocialIcons} id="social-icons-footer" />
    </footer>
    """
  end
end
