class MongoidConnectionMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  ensure
    clean_connection
  end

  def clean_connection
    id = Thread.current.object_id
    session = Mongoid.default_session

    pool = session.cluster.seeds.first.send(:pool)
    conn = pool.send(:pinned)[id]
    conn.expire
    pool.send(:unpinned).push(pool.send(:pinned).delete(id))
  end
end
