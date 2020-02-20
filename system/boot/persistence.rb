Bix::Application.boot(:persistence) do |app|
  start do
    register('container', ROM.container(:sql, app['db.connection']))
  end
end
