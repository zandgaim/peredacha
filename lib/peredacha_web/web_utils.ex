defmodule PeredachaWeb.WebUtils do
  use PeredachaWeb, :html

  def nav_link(assigns) do
    assigns = assign_new(assigns, :is_active, fn -> false end)

    ~H"""
    <a
      href={@href}
      class={"px-4 py-2 rounded-full transition-all font-medium text-sm " <>
      if(@is_active, do: "bg-primary/10 text-primary", else: "hover:bg-white/10 text-white/80 hover:text-white")}
    >
      {@label}
    </a>
    """
  end

  def shop_icon_small(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      class="h-5 w-5"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"
      />
    </svg>
    """
  end

  def lang_switcher(assigns) do
    ~H"""
    <div class="flex items-center space-x-1">
      <button
        phx-click="set_locale"
        phx-value-locale="uk"
        class={"px-3 py-1 rounded-full transition-all duration-300 " <>
               if @locale == "uk",
                 do: "bg-primary text-white font-semibold shadow-md",
                 else: "hover:bg-white/10"}
        aria-label="Switch to Ukrainian"
        disabled={@locale == "uk"}
      >
        UA
      </button>

      <button
        phx-click="set_locale"
        phx-value-locale="en"
        class={"px-3 py-1 rounded-full transition-all duration-300 " <>
               if @locale == "en",
                 do: "bg-primary text-white font-semibold shadow-md",
                 else: "hover:bg-white/10"}
        aria-label="Switch to English"
        disabled={@locale == "en"}
      >
        EN
      </button>
    </div>
    """
  end

  def phone_icon_main(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      class="h-6 w-6"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"
      />
    </svg>
    """
  end

  def phone_icon_sm(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      class="h-4 w-4"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"
      />
    </svg>
    """
  end
end
