defmodule PeredachaWeb.Components.Footer do
  use PeredachaWeb, :html

  alias PeredachaWeb.Components.SocialIcons

  def draw(assigns) do
    ~H"""
    <footer class="footer footer-horizontal footer-center bg-neutral text-neutral-content p-10">
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
          {gettext("5 Передача")} <br /> {gettext("СТО по ремонту КПП Renault")}
        </p>
        
        <p>{gettext("Copyright © %{year}. Всі права захищено.", year: DateTime.utc_now().year)}</p>
      </aside>
       <SocialIcons.draw />
    </footer>
    """
  end
end
