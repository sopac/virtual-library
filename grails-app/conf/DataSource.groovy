dataSource {
    pooled = true
    driverClassName = "org.postgresql.Driver"
    username = "postgres"
    password = "erlang44"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = true
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
    hibernate.dialect='org.hibernate.dialect.PostgreSQLDialect'
}

// environment specific settings
environments {
	development {
		dataSource {
			dbCreate = "update" // one of 'create', 'create-drop','update'
			url = "jdbc:postgresql:virlib_db"
		}
	}
	test {
		dataSource {
			dbCreate = "update"
			url = "jdbc:postgresql:virlib_db"
		}
	}
	production {
		dataSource {
			dbCreate = "update"
			url = "jdbc:postgresql:virlib_db"
		}
	}
}

