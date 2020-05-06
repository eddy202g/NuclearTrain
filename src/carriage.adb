
with Ada.Text_IO;
package body Carriage with SPARK_Mode is
   
   procedure removeCarriage (thisCarriage : in out CarriageRecord) is
   begin
      if(thisCarriage.knuckle = Coupled and thisCarriage.pin = Locked) then
      thisCarriage.pin := Unlocked;
         thisCarriage.knuckle := Decoupled;
         end if;
   end removeCarriage;
   
    procedure addCarriage (thisCarriage : in out CarriageRecord) is
   begin
      if(thisCarriage.pin = Unlocked and thisCarriage.knuckle = Decoupled) then
      thisCarriage.pin := Locked;
         thisCarriage.knuckle := Coupled;
      end if;
      
      end addCarriage;

   function carriageCount return Integer is
      count : Integer := 0;
   begin
      if (C1.pin = Locked) then count := count + 1;
      end if;
      if (C2.pin = Locked) then count := count + 1;
      end if;
      if (C3.pin = Locked) then count := count + 1;
        end if;
         return count;
      end carriageCount;
   
end Carriage;
