import Exseed

page_id = 1

seed CedaRealty.Page do
  id page_id

  parent_id nil

  title "Test"

  slug "test"

  full_path "/test"

  body "<h1>Testing</h1>"

  style ""

  script ""

  meta_description ""

  meta_keywords ""

  show_in_menu true

  published true

  order page_id - 1
end

page_id = page_id + 1

seed CedaRealty.Page do
  id page_id

  parent_id nil

  title "Real Page"

  slug "real-page"

  full_path "/real-page"

  body "<p>No for real.</p>"

  style "p { color: red; }"

  script ""

  meta_description ""

  meta_keywords ""

  show_in_menu true

  published true

  order page_id - 1
end

page_id = page_id + 1
