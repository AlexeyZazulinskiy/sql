Задание 1
Создайте таблицу users_old, аналогичную таблице users. Создайте процедуру, с помощью которой можно переместить любого (одного) пользователя из таблицы users в таблицу users_old. (использование транзакции с выбором commit или rollback – обязательно).

  Создание таблицы
DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
	id INT PRIMARY KEY, 
    firstname varchar(50), 
    lastname varchar(50), 
    email varchar(120)
);

  Процедура
DROP PROCEDURE IF EXISTS lesson_4.move;
DELIMITER $$
$$
CREATE PROCEDURE lesson_4.move(IN u_index INT) 
	DETERMINISTIC
BEGIN
INSERT INTO users_old (id, firstname, lastname, email) 
SELECT id, firstname, lastname, email 
	FROM users 
	WHERE users.id = u_index;
DELETE FROM users 
	WHERE users.id = u_index;
COMMIT;

END$$
DELIMITER ;

Задание 2
Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP PROCEDURE IF EXISTS lesson_4.hello;

DELIMITER $$
$$
CREATE FUNCTION  lesson_4.hello()
	RETURNS VARCHAR(25) 
	DETERMINISTIC
    
BEGIN
	DECLARE result_text VARCHAR(25);
SELECT CASE 
	WHEN 6 > TIMEDIFF( CURRENT_TIME, '12:00:00') >= 0 THEN 'Добрый день'
	WHEN 6 > TIMEDIFF( CURRENT_TIME, '06:00:00') >= 0 THEN 'Доброе утро'
	WHEN 6 > TIMEDIFF( CURRENT_TIME, '00:00:00') >= 0 THEN 'Доброй ночи'
	ELSE 'Добрый вечер'
END INTO result_text;
RETURN result_text;
END$$
DELIMITER ;
