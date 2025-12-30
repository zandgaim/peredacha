defmodule PeredachaWeb.Pages.GallerySections do
  @moduledoc """
  Provides a centralized list of gallery `sections` used by the gallery page.
  Keeping the data here makes the `GalleryPage` module smaller and easier to test.
  """

  @spec sections() :: list()
  def sections do
    [
      %{
        id: "sto",
        title: "CТО 5 Передача",
        subtitle: "Diagnostic Center",
        description: "Where the magic happens. State-of-the-art diagnostic tools.",
        cover: "/images/gallery/main_cto.jpg",
        images: [
          "/images/gallery/main_cto.jpg",
          "/images/gallery/third_cto.png",
          "/images/gallery/second_cto.jpg"
        ]
      },
      %{
        id: "shop",
        title: "Автомагазин",
        subtitle: "Premium Care",
        description: "Premium leather care and deep cleaning services.",
        cover: "/images/gallery/mag_5.png",
        images: [
          "/images/gallery/mag_5.png",
          "/images/gallery/mag_3.png",
          "/images/gallery/mag_4.png",
          "/images/gallery/mag_2.png"
        ]
      },
      %{
        id: "tools",
        title: "Обладнання",
        subtitle: "Restoration",
        description: "Removing swirls and scratches for a mirror finish.",
        cover: "/images/gallery/tools_2.png",
        images: [
          "/images/gallery/tools_2.png",
          "/images/gallery/tools_1.png",
          "/images/gallery/tools_3.png",
          "/images/gallery/box_2.png"
        ]
      },
      %{
        id: "work",
        title: "Роботи СТО",
        subtitle: "Restoration",
        description: "Removing swirls and scratches for a mirror finish.",
        cover: "/images/blog/profesijna-diagnostika-ta-remont-korobok-reno.jpg",
        images: [
          "/images/blog/profesijna-diagnostika-ta-remont-korobok-reno.jpg",
          "/images/blog/koli-rekomenduyetsya-zamina-avtomata-na-mehaniku-v-avtomobilyah-renault-768x512.jpg",
          "/images/blog/mkpp-renault-kakie-priznaki-signaliziruyut-o-neobhodimosti-remonta.jpg",
          "/images/blog/try-hytroshci-jaki-majstry-cto-vas.png"
        ]
      },
      %{
        id: "indor",
        title: "Всередині",
        subtitle: "Ceramic Coating",
        description: "Ceramic coating and professional paint correction.",
        cover: "/images/gallery/box_2.png",
        images: [
          "/images/gallery/box_2.png",
          "/images/gallery/box_1.png",
          "/images/gallery/box_3.png"
        ]
      }
    ]
  end
end
