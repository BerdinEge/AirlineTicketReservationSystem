CREATE DEFINER=`root`@`localhost` TRIGGER `airlinesystem`.`flight_leg_BEFORE_INSERT_2` BEFORE INSERT ON `flight_leg` FOR EACH ROW
BEGIN
	if new.Departure_airport_code=new.Arrival_airport_code
    then
    signal sqlstate '45000' set message_text = 'Kalkis havalimanı ve iniş havalimanı aynı olamaz!';
	end if;
END