#!/bin/sh
IFS='' read -r -d '' SQL <<"EOF"
DROP FUNCTION IF EXISTS remove_first_letter_a;
DELIMITER //
CREATE FUNCTION `remove_first_letter_a`(string_a VARCHAR(1000))
    RETURNS VARCHAR(1000)
    DETERMINISTIC
BEGIN
    IF STRCMP(SUBSTRING(string_a, 1, 1), 'a') = 0 THEN
        RETURN SUBSTRING(string_a, 2, CHAR_LENGTH(string_a) - 1);
    ELSE
        RETURN string_a;
    END IF;
END//
DELIMITER ;
UPDATE users
SET nick_name = remove_first_letter_a(nick_name) where nick_name like 'a%';
EOF


#Using this line if mysql isn't running inside docker container.
#echo $SQL | /usr/local/opt/mysql@5.7/bin/mysql -pexample public

docker exec -i 053a845d8e1a mysql -pexample public <<EOF
DROP FUNCTION IF EXISTS remove_first_letter_a;
DELIMITER //
CREATE FUNCTION remove_first_letter_a(string_a VARCHAR(1000))
    RETURNS VARCHAR(1000)
    DETERMINISTIC
BEGIN
    IF STRCMP(SUBSTRING(string_a, 1, 1), 'a') = 0 THEN
        RETURN SUBSTRING(string_a, 2, CHAR_LENGTH(string_a) - 1);
    ELSE
        RETURN string_a;
    END IF;
END//
DELIMITER ;
UPDATE users
SET nick_name = remove_first_letter_a(nick_name) where nick_name like 'a%';
EOF
