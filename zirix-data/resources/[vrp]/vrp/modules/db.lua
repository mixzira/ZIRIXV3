vRP.prepare('vRP/create_vrp_homes_permissions',
    [[
        CREATE TABLE IF NOT EXISTS `vrp_homes_permissions` (
            `owner` int(11) NOT NULL,
            `user_id` int(11) NOT NULL,
            `garage` int(11) NOT NULL,
            `home` varchar(100) NOT NULL DEFAULT '',
            `tax` varchar(24) NOT NULL DEFAULT ''
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]]
)

vRP.prepare('vRP/create_vrp_srv_data',
    [[
        CREATE TABLE IF NOT EXISTS `vrp_srv_data` (
            `dkey` varchar(100) NOT NULL,
            `dvalue` text DEFAULT NULL,
            PRIMARY KEY (`dkey`)
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]]
)

vRP.prepare('vRP/create_vrp_users',
    [[
        CREATE TABLE IF NOT EXISTS `vrp_users` (
            `id` int(11) NOT NULL AUTO_INCREMENT,
            `whitelisted` tinyint(1) DEFAULT NULL,
            `banned` tinyint(1) DEFAULT NULL,
            `ip` varchar(255) NOT NULL DEFAULT '0.0.0',
            `last_login` varchar(255) NOT NULL DEFAULT '0.0.0',
            `coins` int(50) NOT NULL DEFAULT '0',
            PRIMARY KEY (`id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]]
)

vRP.prepare('vRP/create_vrp_user_data',
    [[
        CREATE TABLE IF NOT EXISTS `vrp_user_data` (
            `user_id` int(11) NOT NULL,
            `dkey` varchar(100) NOT NULL,
            `dvalue` text DEFAULT NULL,
            PRIMARY KEY (`user_id`,`dkey`),
            CONSTRAINT `fk_user_data_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]]
)

vRP.prepare('vRP/create_vrp_user_identities',
    [[
        CREATE TABLE IF NOT EXISTS `vrp_user_identities` (
            `user_id` int(11) NOT NULL,
            `registration` varchar(20) DEFAULT NULL,
            `phone` varchar(20) DEFAULT NULL,
            `firstname` varchar(50) DEFAULT NULL,
            `name` varchar(50) DEFAULT NULL,
            `age` int(11) DEFAULT NULL,
            `driverlicense` int(1) NOT NULL DEFAULT 0,
            `fugitive` int(1) NOT NULL DEFAULT 0,
            `crimerecord` int(1) NOT NULL DEFAULT 0,
            `gunlicense` int(1) NOT NULL DEFAULT 0,
            `foto` varchar(200) DEFAULT NULL,
            PRIMARY KEY (`user_id`),
            KEY `registration` (`registration`),
            KEY `phone` (`phone`),
            CONSTRAINT `fk_user_identities_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]]
)

vRP.prepare('vRP/create_vrp_user_ids',
    [[
        CREATE TABLE IF NOT EXISTS `vrp_user_ids` (
            `identifier` varchar(100) NOT NULL,
            `user_id` int(11) DEFAULT NULL,
            KEY `identifier` (`identifier`),
            KEY `fk_user_ids_users` (`user_id`),
            CONSTRAINT `fk_user_ids_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]]
)

vRP.prepare('vRP/create_vrp_user_moneys',
    [[
        CREATE TABLE IF NOT EXISTS `vrp_user_moneys` (
            `user_id` int(11) NOT NULL,
            `bank` int(11) DEFAULT NULL,
            PRIMARY KEY (`user_id`),
            CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]]
)

vRP.prepare('vRP/create_vrp_user_vehicles',
    [[
        CREATE TABLE IF NOT EXISTS `vrp_user_vehicles` (
            `user_id` int(11) NOT NULL,
            `vehicle` varchar(100) NOT NULL,
            `detido` int(1) NOT NULL DEFAULT 0,
            `time` varchar(24) NOT NULL DEFAULT '0',
            `engine` int(4) NOT NULL DEFAULT 1000,
            `body` int(4) NOT NULL DEFAULT 1000,
            `fuel` int(3) NOT NULL DEFAULT 100,
            `ipva` varchar(50) DEFAULT NULL,
            PRIMARY KEY (`user_id`,`vehicle`),
            CONSTRAINT `fk_user_vehicles_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
    ]]
)

vRP.prepare('vRP/create_vrp_priority',
    [[
        CREATE TABLE IF NOT EXISTS `vrp_priority` (
            `priority` int(10) DEFAULT NULL,
            `steam` varchar(50) DEFAULT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]]
)
vRP.prepare('vRP/create_vrp_benefits',
    [[
        CREATE TABLE IF NOT EXISTS `vrp_benefits` (
            `chars` int(10) NOT NULL DEFAULT 4,
            `steam` varchar(50) DEFAULT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]]
)

vRP.prepare('vRP/create_vrp_stock_exchange',
    [[
        CREATE TABLE IF NOT EXISTS `vrp_stock_exchange` (
            `name` varchar(50) DEFAULT NULL,
            `points` int(10) DEFAULT 100
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]]
)

vRP.prepare('vRP/create_vrp_estoque',
    [[
        CREATE TABLE IF NOT EXISTS `vrp_estoque` (
            `vehicle` varchar(100) NOT NULL,
            `quantidade` int(11) NOT NULL
        ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
        INSERT INTO `vrp_estoque` (`vehicle`, `quantidade`) VALUES
	('deveste', 10);
    ]]
)


CreateThread(function()
    
    vRP.execute('vRP/create_vrp_srv_data')
    vRP.execute('vRP/create_vrp_users')
    vRP.execute('vRP/create_vrp_user_data')
    vRP.execute('vRP/create_vrp_user_identities')
    vRP.execute('vRP/create_vrp_user_ids')
    vRP.execute('vRP/create_vrp_user_moneys')
    vRP.execute('vRP/create_vrp_user_vehicles')
    vRP.execute('vRP/create_vrp_priority')
    vRP.execute('vRP/create_vrp_benefits')
    vRP.execute('vRP/create_vrp_stock_exchange')
    vRP.execute('vRP/create_vrp_estoque')
    vRP.execute('vRP/create_vrp_homes_permissions')
end)