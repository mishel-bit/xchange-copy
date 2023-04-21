# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "dark-mode", preload: true 
pin "sidebar", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "flowbite", to: "https://cdnjs.cloudflare.com/ajax/libs/flowbite/1.6.4/flowbite.turbo.min.js"

# pin "flowbite", to: "https://ga.jspm.io/npm:flowbite@1.6.4/lib/esm/index.js"
# pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.7/lib/index.js"
pin "echarts", to: "echarts.min.js"
pin "echarts/theme/dark", to: "echarts/theme/dark.js"
