require! \koa-rethinkdb-pool

global.r = require \rethinkdb

co ->*
  connection = yield r.connect do
    host: olio.config.db.host
    port: olio.config.db.port
    db:   olio.config.db.name
  try
    yield r.db-create olio.config.db.name .run connection
    info "[db] Created database '#{olio.config.db.name}'"
  for collection in olio.config.db.collections
    try
      yield r.db(olio.config.db.name).table-create collection .run connection
      info "[db] Created collection '#collection'"

module.exports = koa-rethinkdb-pool do
  r: r
  connect-options:
    host: olio.config.db.host
    port: olio.config.db.port
    db:   olio.config.db.name
