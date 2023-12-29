# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "https://ga.jspm.io/npm:@hotwired/turbo-rails@8.0.0-beta.1/app/javascript/turbo/index.js", preload: true
pin "@hotwired/turbo", to: "https://ga.jspm.io/npm:@hotwired/turbo@8.0.0-beta.1/dist/turbo.es2017-esm.js"

pin "stimulus", to: "https://ga.jspm.io/npm:stimulus@3.2.2/dist/stimulus.js"
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.2.2/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

pin_all_from "app/javascript/controllers", under: "controllers"
