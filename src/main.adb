with Carriage; use Carriage;
with Rods; use Rods;
with reactor; use reactor;
with Train; use Train;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;



procedure Main is
   nt : train.TrainRecord;
   UserInput : Integer;

   procedure TrainStatus is
   begin
      Put_Line("");
      Put_Line(" ////////////////////////////////////////////////////////////");
      Put_Line(" //");
      Put_Line(" //  Current speed: " & nt.currentSpeed'Image);
      Put_Line(" //  No. of attached cars: " & carriageCount'Image);
      Put_Line(" //  No. of attached rods: " & nt.rods.top'Image);
      Put_Line(" //     ----------------");
      Put_Line(" //  Current reactor levels: ");
      Put_Line(" //         Temperature: " & nt.reactor.temp'Image);
      Put_Line(" //         Water: " & nt.reactor.water'Image);
      Put_Line(" //         Electricity: " & nt.reactor.electricity'Image);
      Put_Line(" //         Status: " & nt.reactor.status'Image);
      Put_Line(" //");
      Put_Line(" ////////////////////////////////////////////////////////////");
      Put_Line("");
   end TrainStatus;

   procedure TrainMovingMenu is
   begin
      Put_Line(" 1 - Add a control rod");
      Put_Line(" 2 - Remove a control rod");
      Put_Line(" 3 - Stop the train");
      Put_Line(" 4 - Add a carriage");
      Put_Line(" 5 - Remove a carriage");
      Put_Line(" 6 - Restart the train");
      Put_Line("");
   end TrainMovingMenu;




   procedure ClearScreen is
   begin
      Put(ASCII.ESC & "[2J");
   end ClearScreen;

   procedure AddingCarriage is
   begin
      if nt.currentSpeed = 0 then
         if (C1.knuckle = Coupled and C1.pin = Locked and
               C2.knuckle /= Coupled and C2.Pin /= Locked) then
            addCarriage(C2);
            Put_Line("Carriage 2 added");
            delay 1.0;

         elsif (C2.knuckle = Coupled and C2.Pin = Locked and
                  C3.knuckle /= Coupled and C3.Pin /= Locked) then
            addCarriage(C3);
            Put_Line("Carriage 3 added");
            delay 1.0;

         elsif (C3.knuckle = Coupled and C3.Pin = Locked) then
            Put_Line("");
            Put_Line("*** ERROR -Cannot add more carriages - ERROR ***");
            delay 3.0;
         end if;
      else
         Put_Line("*** WARNING - Train must be stopped before adding carriage ***");
         delay 3.0;
      end if;
   end AddingCarriage;

   procedure RemovingCarriage is
   begin
      if nt.currentSpeed = 0 then
         if (C3.pin = Locked and C2.pin = Locked and C1.pin = Locked) then
            removeCarriage(C3);
            Put_Line("Carriage 3 removed");
            delay 1.0;

         elsif (C3.pin = Unlocked and C2.pin = Locked and C1.pin = Locked) then
            removeCarriage(C2);
            Put_Line("Carriage 2 removed");
            delay 1.0;

         elsif (C3.pin = Unlocked and C2.pin = Unlocked and C1.pin = Locked) then
            Put_Line("");
            Put_Line("*** ERROR -Cannot remove any more cars - ERROR ***");
            delay 3.0;
         end if;
      else
         Put_Line("*** WARNING - Train must be stopped before removing carriage ***");
         delay 3.0;
      end if;
   end RemovingCarriage;

begin
   TrainStatus;
   TrainMovingMenu;

   while UserInput /= 0 loop

      Put("Enter number to select an option: ");
      get(UserInput);

      if UserInput = 1 then
         AddRod(nt.rods, 'C');
         decreaseTemp(nt.reactor);
         RegulateSpeed(nt);
         ClearScreen;

         TrainStatus;

         TrainMovingMenu;

          if nt.reactor.status = Overheated then
            Put_Line("*** OVERHEATING - PERFORMING EMERGENCY STOP ***");
            delay 3.0;
         end if;


         EmergencyStop(nt);

         DisableReactor(nt);

         ClearScreen;

         TrainStatus;

         TrainMovingMenu;

      elsif UserInput = 2 then
         RemoveRod(nt.rods);
         increaseTemp(nt.reactor);
         RegulateSpeed(nt);

         ClearScreen;

         TrainStatus;

         TrainMovingMenu;

         if nt.reactor.status = Overheated then
            Put_Line("*** OVERHEATING - PERFORMING EMERGENCY STOP ***");
            delay 3.0;
         end if;


         EmergencyStop(nt);

         DisableReactor(nt);

         ClearScreen;

         TrainStatus;

         TrainMovingMenu;

      elsif UserInput = 3 then
         StopTrain(nt);


         ClearScreen;

         TrainStatus;

         TrainMovingMenu;


      elsif UserInput = 4 then

         AddingCarriage;

         ClearScreen;

         TrainStatus;

         TrainMovingMenu;

      elsif UserInput = 5 then

         RemovingCarriage;

         ClearScreen;

         TrainStatus;

         TrainMovingMenu;

      elsif UserInput = 6 then

         RestartTrain(nt);
         RegulateSpeed(nt);

         ClearScreen;

         TrainStatus;

         TrainMovingMenu;
      end if;
   end loop;

end Main;
