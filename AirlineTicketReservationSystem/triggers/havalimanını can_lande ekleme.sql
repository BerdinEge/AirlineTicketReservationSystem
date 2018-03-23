CREATE DEFINER=`root`@`localhost` TRIGGER `airlinesystem`.`airport_AFTER_INSERT` AFTER INSERT ON `airport` FOR EACH ROW
BEGIN
	DECLARE v_Airplane_type_name varchar(45) DEFAULT 0;
	DECLARE finished BOOL DEFAULT FALSE;
	DECLARE Airplane_type_name_gezen CURSOR FOR (select a.Airplane_type_name
											 from airplane_type a
											 where a.Max_seats<=new.Capacity);

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = TRUE;
	OPEN Airplane_type_name_gezen; 
	repeat FETCH Airplane_type_name_gezen INTO v_Airplane_type_name ;
		IF NOT finished THEN
			insert into can_land values(v_Airplane_type_name,new.Airport_code);
		end if;
	UNTIL finished END REPEAT;
	CLOSE Airplane_type_name_gezen;
END