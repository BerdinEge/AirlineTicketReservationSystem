CREATE DEFINER=`root`@`localhost` TRIGGER `airlinesystem`.`airplane_type_AFTER_INSERT` AFTER INSERT ON `airplane_type` FOR EACH ROW
BEGIN
	DECLARE v_Airport_code varchar(4) DEFAULT '2202';
	DECLARE finished BOOL DEFAULT FALSE;
	DECLARE Airport_code_gezen CURSOR FOR (select a.Airport_code
											 from airport a
											 where a.Capacity>=new.Max_seats);

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE;
	OPEN Airport_code_gezen; 
	repeat FETCH Airport_code_gezen INTO v_Airport_code ;
		IF NOT finished THEN
			insert into can_land values(new.Airplane_type_name,v_Airport_code);
		end if;
	UNTIL finished END REPEAT;
	CLOSE Airport_code_gezen;
END