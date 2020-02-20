Bix::Application.boot(:persistence) do |app|
  start do
    register('container', ROM.container(:sql, app['db.config'].gateways[:default].connection))
  end
end
