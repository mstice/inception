<?php

define( 'DB_NAME', getenv('DB_NAME') );
define( 'DB_USER', getenv('DB_USER') );
define( 'DB_PASSWORD', getenv('DB_PASSWORD') );
define( 'DB_HOST', getenv('DB_HOST') );
define( 'WP_HOME', getenv('WP_FULL_URL') );
define( 'WP_SITEURL', getenv('WP_FULL_URL') );

define( 'AUTH_KEY',         'Y`KUy3!N7tM8' );
define( 'SECURE_AUTH_KEY',  '58(uuhE9$[yu' );
define( 'LOGGED_IN_KEY',    'fW<6a27}{b+a' );
define( 'NONCE_KEY',        '>k,5%=O.07.k' );
define( 'AUTH_SALT',        'J/FYjP7316]L' );
define( 'SECURE_AUTH_SALT', '8\+B)9,0K.h1' );
define( 'LOGGED_IN_SALT',   '210P.Ba2[<5U' );
define( 'NONCE_SALT',       '&~1w6;Cz334#' );

$table_prefix = 'wp_';

define( 'WP_DEBUG', true);

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
