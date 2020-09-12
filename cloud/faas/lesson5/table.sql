CREATE TABLE shifts.worker_arrival (
	`id` int(11) auto_increment NOT NULL,
	`date` TIMESTAMP NOT NULL,
	name varchar(100) NOT NULL,
    PRIMARY KEY (`id`)
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8
COLLATE=utf8_general_ci;
