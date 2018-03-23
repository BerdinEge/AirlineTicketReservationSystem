CREATE DEFINER=`root`@`localhost` TRIGGER `airlinesystem`.`seat_reservation_AFTER_INSERT` AFTER INSERT ON `seat_reservation` FOR EACH ROW
BEGIN
	update leg_instance
    set Number_of_available_seats=Number_of_available_seats-1
    where Flight_number=new.Flight_number and Leg_number=new.Leg_number and Date=new.Date;
END