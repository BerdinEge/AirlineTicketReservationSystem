CREATE DEFINER=`root`@`localhost` TRIGGER `airlinesystem`.`flight_leg_BEFORE_INSERT` BEFORE INSERT ON `flight_leg` FOR EACH ROW
BEGIN
	if CAST(new.Scheduled_departure_time AS time)> CAST(new.Scheduled_arrival_time as time)
        then
		signal sqlstate '45000' set message_text = 'Kalkis Saati Varis SAATINDEN BUYUK OLAMAZ';
        end if;
END