require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'webdrivers/chromedriver'

Capybara.configure do |c|
  c.run_server = false
  c.default_driver = :selenium
  c.app_host = 'https://esic.cgu.gov.br/'
end

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

class FuckTheGovernment
  include Capybara::DSL

  def action_time
    visit '/sistema/site/index.aspx'

    fill_in 'ConteudoForaDoPortlet_txtUsuario', with: "SEU_USERNAME"
    fill_in 'ConteudoForaDoPortlet_txtSenha', with: "SEU_PASSWORD"

    find('input[id="ConteudoForaDoPortlet_btnEntrar"]').click

    # só pra ter certeza de que logou, vamos dormir 2 segundinhos
    sleep(2)

    visit '/sistema/Pedido/RegistroPedido.aspx'

    puts "Loguei, entrei e fui pro registro, porraaaa"
  end
end

FuckTheGovernment.new.action_time
